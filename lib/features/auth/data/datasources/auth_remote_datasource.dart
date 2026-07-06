import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDatasource {
  Stream<UserModel?> get authStateChanges;
  
  UserModel? get currentUser;

  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  });

  Future<void> sendPasswordResetEmail(String email);

  Future<void> sendOtp(String phoneNumber);

  Future<UserModel> verifyOtp({
    required String verificationId,
    required String smsCode,
  });

  Future<UserModel> signInWithGoogle();

  Future<UserModel> signInWithApple();

  Future<UserModel> signInAnonymously();

  Future<UserModel> linkWithCredential({
    required String providerId,
    required AuthCredential credential,
  });

  Future<void> logOut();

  Future<void> deleteAccount();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasourceImpl({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  @override
  Stream<UserModel?> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((User? firebaseUser) {
      if (firebaseUser == null) return null;
      return _mapFirebaseUserToModel(firebaseUser);
    });
  }

  @override
  UserModel? get currentUser {
    final firebaseUser = _firebaseAuth.currentUser;
    if (firebaseUser == null) return null;
    return _mapFirebaseUserToModel(firebaseUser);
  }

  @override
  Future<UserModel> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'Sign in succeeded but user is null.',
        );
      }
      return _mapFirebaseUserToModel(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Authentication failed: ${e.code}');
    }
  }

  @override
  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'Registration succeeded but user is null.',
        );
      }
      await credential.user!.updateDisplayName(name);
      return _mapFirebaseUserToModel(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed: ${e.code}');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Password reset failed: ${e.code}');
    }
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    // Note: Verification triggering typically occurs inside presentation/controllers,
    // but we encapsulate SDK access patterns here.
    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _firebaseAuth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw Exception(e.message ?? 'Verification failed: ${e.code}');
        },
        codeSent: (String verificationId, int? resendToken) {
          // Typically handled via callbacks inside UI controllers or state machines
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'OTP dispatch failed: ${e.code}');
    }
  }

  @override
  Future<UserModel> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      );
      final authResult = await _firebaseAuth.signInWithCredential(credential);
      if (authResult.user == null) {
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'OTP verification succeeded but user is null.',
        );
      }
      return _mapFirebaseUserToModel(authResult.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'OTP validation failed: ${e.code}');
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    // High-fidelity implementation pattern. GoogleSignIn would be implemented
    // at the client integration layer; here we accept credentials or complete flow.
    throw UnimplementedError('Google Sign-In relies on platform-native SDK integration.');
  }

  @override
  Future<UserModel> signInWithApple() async {
    throw UnimplementedError('Apple Sign-In relies on platform-native SDK integration.');
  }

  @override
  Future<UserModel> signInAnonymously() async {
    try {
      final credential = await _firebaseAuth.signInAnonymously();
      if (credential.user == null) {
        throw FirebaseAuthException(
          code: 'null-user',
          message: 'Anonymous login succeeded but user is null.',
        );
      }
      return _mapFirebaseUserToModel(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Anonymous login failed: ${e.code}');
    }
  }

  @override
  Future<UserModel> linkWithCredential({
    required String providerId,
    required AuthCredential credential,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('No active authenticated session.');
      final linkedResult = await user.linkWithCredential(credential);
      if (linkedResult.user == null) throw Exception('Credential linking failed.');
      return _mapFirebaseUserToModel(linkedResult.user!);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Account linking failed: ${e.code}');
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.delete();
    }
  }

  UserModel _mapFirebaseUserToModel(User user) {
    final providers = user.providerData.map((info) => info.providerId).toList();
    return UserModel(
      uid: user.uid,
      email: user.email,
      phoneNumber: user.phoneNumber,
      displayName: user.displayName,
      photoURL: user.photoURL,
      providerId: user.providerData.isNotEmpty ? user.providerData.first.providerId : null,
      createdAt: user.metadata.creationTime,
      lastSignInAt: user.metadata.lastSignInTime,
      isEmailVerified: user.emailVerified,
      isPhoneNumberVerified: user.phoneNumber != null,
      linkedProviders: providers,
    );
  }
}
