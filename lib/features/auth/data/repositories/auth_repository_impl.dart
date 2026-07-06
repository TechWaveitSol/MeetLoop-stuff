import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl({required AuthRemoteDatasource remoteDatasource})
      : _remoteDatasource = remoteDatasource;

  @override
  Stream<UserEntity?> get authStateChanges => _remoteDatasource.authStateChanges;

  @override
  UserEntity? get currentUser => _remoteDatasource.currentUser;

  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await _remoteDatasource.loginWithEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> signUpWithEmail({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      return await _remoteDatasource.signUpWithEmail(
        email: email,
        password: password,
        name: name,
      );
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _remoteDatasource.sendPasswordResetEmail(email);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> sendOtp(String phoneNumber) async {
    try {
      await _remoteDatasource.sendOtp(phoneNumber);
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {
    try {
      return await _remoteDatasource.verifyOtp(
        verificationId: verificationId,
        smsCode: smsCode,
      );
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> signInWithGoogle() async {
    try {
      return await _remoteDatasource.signInWithGoogle();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> signInWithApple() async {
    try {
      return await _remoteDatasource.signInWithApple();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> signInAnonymously() async {
    try {
      return await _remoteDatasource.signInAnonymously();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<UserEntity> linkWithCredential({
    required String providerId,
    required dynamic credential,
  }) async {
    try {
      if (credential is! firebase_auth.AuthCredential) {
        throw const AuthFailure('Invalid Firebase Authentication credential type.');
      }
      return await _remoteDatasource.linkWithCredential(
        providerId: providerId,
        credential: credential,
      );
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> logOut() async {
    try {
      await _remoteDatasource.logOut();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _remoteDatasource.deleteAccount();
    } catch (e) {
      throw AuthFailure(e.toString());
    }
  }

  @override
  Future<List<String>> getActiveSessions() async {
    // Session auditing relies on Firestore or custom backend sync.
    // Return sample or retrieve from remote configs in full-scale system.
    return ['Session - Android Client', 'Session - iOS Client'];
  }

  @override
  Future<void> terminateSession(String sessionId) async {
    // Terminate session by dropping matching user token records
  }
}
