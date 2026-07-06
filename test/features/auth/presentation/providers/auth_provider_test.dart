import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meetloop/features/auth/domain/entities/user_entity.dart';
import 'package:meetloop/features/auth/domain/repositories/auth_repository.dart';
import 'package:meetloop/features/auth/presentation/providers/auth_provider.dart';

class MockAuthRepository extends Mock implements AuthRepository {
  @override
  Future<UserEntity> loginWithEmail({
    required String email,
    required String password,
  }) {
    return super.noSuchMethod(
      Invocation.method(#loginWithEmail, [], {#email: email, #password: password}),
      returnValue: Future.value(const UserEntity(uid: 'test_uid', email: 'test@example.com')),
      returnValueForMissingStub: Future.value(const UserEntity(uid: 'test_uid', email: 'test@example.com')),
    ) as Future<UserEntity>;
  }

  @override
  Future<void> logOut() {
    return super.noSuchMethod(
      Invocation.method(#logOut, []),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    ) as Future<void>;
  }
}

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthController authController;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authController = AuthController(mockAuthRepository);
  });

  group('AuthController tests', () {
    test('initial state is default AuthControllerState', () {
      expect(authController.state.isLoading, false);
      expect(authController.state.errorMessage, null);
      expect(authController.state.user, null);
    });

    test('loginWithEmail sets isLoading and updates user on success', () async {
      const testUser = UserEntity(uid: 'test_uid', email: 'test@example.com');
      
      when(mockAuthRepository.loginWithEmail(
        email: 'test@example.com',
        password: 'password',
      )).thenAnswer((_) async => testUser);

      final future = authController.loginWithEmail('test@example.com', 'password');

      expect(authController.state.isLoading, true);

      await future;

      expect(authController.state.isLoading, false);
      expect(authController.state.user, testUser);
      expect(authController.state.errorMessage, null);
    });

    test('loginWithEmail sets errorMessage on failure', () async {
      when(mockAuthRepository.loginWithEmail(
        email: 'test@example.com',
        password: 'wrong_password',
      )).thenThrow(Exception('Incorrect Credentials'));

      await authController.loginWithEmail('test@example.com', 'wrong_password');

      expect(authController.state.isLoading, false);
      expect(authController.state.user, null);
      expect(authController.state.errorMessage, contains('Incorrect Credentials'));
    });
  });
}
