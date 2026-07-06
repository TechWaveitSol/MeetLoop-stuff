import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/profile_model.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> getProfile(String uid);

  Future<void> updateProfile(ProfileModel profile);

  Future<void> blockUser(String currentUid, String blockedUid);

  Future<void> muteUser(String currentUid, String mutedUid);

  Future<String> uploadProfilePhoto(String uid, String filePath);

  Future<void> deletePhoto(String uid, String photoUrl);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  ProfileRemoteDatasourceImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? storage,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  @override
  Future<ProfileModel> getProfile(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) {
        throw Exception('Profile not found.');
      }
      return ProfileModel.fromJson(doc.data()!);
    } catch (e) {
      throw Exception('Failed to fetch profile: ${e.toString()}');
    }
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    try {
      await _firestore.collection('users').doc(profile.uid).update(profile.toJson());
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }

  @override
  Future<void> blockUser(String currentUid, String blockedUid) async {
    try {
      await _firestore.collection('users').doc(currentUid).update({
        'blockedUsers': FieldValue.arrayUnion([blockedUid])
      });
    } catch (e) {
      throw Exception('Failed to block user: ${e.toString()}');
    }
  }

  @override
  Future<void> muteUser(String currentUid, String mutedUid) async {
    try {
      await _firestore.collection('users').doc(currentUid).update({
        'mutedUsers': FieldValue.arrayUnion([mutedUid])
      });
    } catch (e) {
      throw Exception('Failed to mute user: ${e.toString()}');
    }
  }

  @override
  Future<String> uploadProfilePhoto(String uid, String filePath) async {
    try {
      final ref = _storage.ref().child('users/$uid/profile_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = await ref.putFile(File(filePath));
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      
      // Update photos list in FireStore
      await _firestore.collection('users').doc(uid).update({
        'photos': FieldValue.arrayUnion([downloadUrl])
      });

      return downloadUrl;
    } catch (e) {
      throw Exception('Failed to upload photo: ${e.toString()}');
    }
  }

  @override
  Future<void> deletePhoto(String uid, String photoUrl) async {
    try {
      // Delete from Firebase Storage first
      final ref = _storage.refFromURL(photoUrl);
      await ref.delete();

      // Update Firestore photos list
      await _firestore.collection('users').doc(uid).update({
        'photos': FieldValue.arrayRemove([photoUrl])
      });
    } catch (e) {
      throw Exception('Failed to delete photo: ${e.toString()}');
    }
  }
}
