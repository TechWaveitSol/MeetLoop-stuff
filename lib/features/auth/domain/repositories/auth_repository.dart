import '../entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity?> get authStateChanges;
  
  UserEntity? get currentUser;

  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserEntity> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<void> sendPasswordResetEmail(String email);

  Future<void> sendOtp(String phoneNumber);

  Future<UserEntity> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<UserEntity> signInWithGoogle();

  Future<UserEntity> signInWithApple();

  Future<UserEntity> signInAnonymously();

  Future<UserEntity> linkWithCredential({
    required String providerId,
    required dynamic credential,
  });

  Future<void> logOut();

  Future<void> deleteAccount();

  Future<List<String>> getActiveSessions();

  Future<void> terminateSession(String sessionId);
}
