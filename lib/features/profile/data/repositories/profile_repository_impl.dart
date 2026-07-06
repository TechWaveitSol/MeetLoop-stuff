import '../../../../core/errors/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/profile_remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDatasource _remoteDatasource;

  ProfileRepositoryImpl({required ProfileRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Future<ProfileEntity> getProfile(String uid) async {
    try {
      return await _remoteDatasource.getProfile(uid);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) async {
    try {
      final model = ProfileModel(
        uid: profile.uid,
        displayName: profile.displayName,
        username: profile.username,
        bio: profile.bio,
        gender: profile.gender,
        pronouns: profile.pronouns,
        dateOfBirth: profile.dateOfBirth,
        isAgeVerified: profile.isAgeVerified,
        height: profile.height,
        languages: profile.languages,
        relationshipStatus: profile.relationshipStatus,
        occupation: profile.occupation,
        education: profile.education,
        religion: profile.religion,
        smokingPreference: profile.smokingPreference,
        drinkingPreference: profile.drinkingPreference,
        pets: profile.pets,
        hobbies: profile.hobbies,
        interests: profile.interests,
        favoriteMusic: profile.favoriteMusic,
        favoriteMovies: profile.favoriteMovies,
        sports: profile.sports,
        photos: profile.photos,
        profileVideoUrl: profile.profileVideoUrl,
        verificationBadge: profile.verificationBadge,
        personalityType: profile.personalityType,
        privacySettings: profile.privacySettings,
        notificationSettings: profile.notificationSettings,
        locationSettings: profile.locationSettings,
        blockedUsers: profile.blockedUsers,
        mutedUsers: profile.mutedUsers,
        friends: profile.friends,
        profileCompletionPercentage: profile.profileCompletionPercentage,
      );
      await _remoteDatasource.updateProfile(model);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> blockUser(String currentUid, String blockedUid) async {
    try {
      await _remoteDatasource.blockUser(currentUid, blockedUid);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> muteUser(String currentUid, String mutedUid) async {
    try {
      await _remoteDatasource.muteUser(currentUid, mutedUid);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<String> uploadProfilePhoto(String uid, String filePath) async {
    try {
      return await _remoteDatasource.uploadProfilePhoto(uid, filePath);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<void> deletePhoto(String uid, String photoUrl) async {
    try {
      await _remoteDatasource.deletePhoto(uid, photoUrl);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
