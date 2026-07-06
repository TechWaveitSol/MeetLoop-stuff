import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../data/datasources/profile_remote_datasource.dart';
import '../../data/repositories/profile_repository_impl.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';

// Firestore Instance Provider
final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// Firebase Storage Instance Provider
final firebaseStorageProvider = Provider<FirebaseStorage>((ref) {
  return FirebaseStorage.instance;
});

// Remote Datasource Provider
final profileRemoteDatasourceProvider = Provider<ProfileRemoteDatasource>((ref) {
  final firestore = ref.watch(firestoreProvider);
  final storage = ref.watch(firebaseStorageProvider);
  return ProfileRemoteDatasourceImpl(firestore: firestore, storage: storage);
});

// Repository Provider
final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final remoteDatasource = ref.watch(profileRemoteDatasourceProvider);
  return ProfileRepositoryImpl(remoteDatasource: remoteDatasource);
});

// State classes for profile controller state handling
class ProfileControllerState {
  final bool isLoading;
  final String? errorMessage;
  final ProfileEntity? profile;

  const ProfileControllerState({
    this.isLoading = false,
    this.errorMessage,
    this.profile,
  });

  ProfileControllerState copyWith({
    bool? isLoading,
    String? errorMessage,
    ProfileEntity? profile,
  }) {
    return ProfileControllerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      profile: profile ?? this.profile,
    );
  }
}

// StateNotifier to drive UI operations and handle asynchronous state transitions
class ProfileController extends StateNotifier<ProfileControllerState> {
  final ProfileRepository _repository;

  ProfileController(this._repository) : super(const ProfileControllerState());

  Future<void> fetchProfile(String uid) async {
    state = state.copyWith(isLoading: true);
    try {
      final profile = await _repository.getProfile(uid);
      state = ProfileControllerState(profile: profile);
    } catch (e) {
      state = ProfileControllerState(errorMessage: e.toString());
    }
  }

  Future<void> updateProfile(ProfileEntity profile) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.updateProfile(profile);
      state = ProfileControllerState(profile: profile);
    } catch (e) {
      state = ProfileControllerState(errorMessage: e.toString());
    }
  }

  Future<void> blockUser(String currentUid, String blockedUid) async {
    try {
      await _repository.blockUser(currentUid, blockedUid);
      if (state.profile != null) {
        final currentBlocked = List<String>.from(state.profile!.blockedUsers);
        if (!currentBlocked.contains(blockedUid)) {
          currentBlocked.add(blockedUid);
          state = state.copyWith(
            profile: state.profile!.copyWith(blockedUsers: currentBlocked),
          );
        }
      }
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  Future<void> uploadPhoto(String uid, String filePath) async {
    state = state.copyWith(isLoading: true);
    try {
      final photoUrl = await _repository.uploadProfilePhoto(uid, filePath);
      if (state.profile != null) {
        final photos = List<String>.from(state.profile!.photos)..add(photoUrl);
        state = ProfileControllerState(
          profile: state.profile!.copyWith(photos: photos),
        );
      }
    } catch (e) {
      state = ProfileControllerState(errorMessage: e.toString());
    }
  }
}

// Profile Controller Provider
final profileControllerProvider = StateNotifierProvider<ProfileController, ProfileControllerState>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return ProfileController(repository);
});
