import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

// Firebase Auth Instance Provider
final firebaseAuthProvider = Provider<firebase_auth.FirebaseAuth>((ref) {
  return firebase_auth.FirebaseAuth.instance;
});

// Remote Datasource Provider
final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  final firebaseAuth = ref.watch(firebaseAuthProvider);
  return AuthRemoteDatasourceImpl(firebaseAuth: firebaseAuth);
});

// Repository Provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDatasource = ref.watch(authRemoteDatasourceProvider);
  return AuthRepositoryImpl(remoteDatasource: remoteDatasource);
});

// Auth State Changes stream provider
final authStateChangesProvider = StreamProvider<UserEntity?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges;
});

// State classes for custom controller state handling
class AuthControllerState {
  final bool isLoading;
  final String? errorMessage;
  final UserEntity? user;

  const AuthControllerState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
  });

  AuthControllerState copyWith({
    bool? isLoading,
    String? errorMessage,
    UserEntity? user,
  }) {
    return AuthControllerState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      user: user ?? this.user,
    );
  }
}

// Controller to drive screen-level actions and update states
class AuthController extends StateNotifier<AuthControllerState> {
  final AuthRepository _repository;

  AuthController(this._repository) : super(const AuthControllerState());

  Future<void> loginWithEmail(String email, String password) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _repository.loginWithEmail(email: email, password: password);
      state = AuthControllerState(user: user);
    } catch (e) {
      state = AuthControllerState(errorMessage: e.toString());
    }
  }

  Future<void> signUpWithEmail(String email, String password, String name) async {
    state = state.copyWith(isLoading: true);
    try {
      final user = await _repository.signUpWithEmail(email: email, password: password, name: name);
      state = AuthControllerState(user: user);
    } catch (e) {
      state = AuthControllerState(errorMessage: e.toString());
    }
  }

  Future<void> sendPasswordReset(String email) async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.sendPasswordResetEmail(email);
      state = const AuthControllerState();
    } catch (e) {
      state = AuthControllerState(errorMessage: e.toString());
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    try {
      await _repository.logOut();
      state = const AuthControllerState();
    } catch (e) {
      state = AuthControllerState(errorMessage: e.toString());
    }
  }
}

// Auth Controller Provider
final authControllerProvider = StateNotifierProvider<AuthController, AuthControllerState>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return AuthController(repository);
});
