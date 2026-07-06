import '../../domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String uid);

  Future<void> updateProfile(ProfileEntity profile);

  Future<void> blockUser(String currentUid, String blockedUid);

  Future<void> muteUser(String currentUid, String mutedUid);

  Future<String> uploadProfilePhoto(String uid, String filePath);

  Future<void> deletePhoto(String uid, String photoUrl);
}
