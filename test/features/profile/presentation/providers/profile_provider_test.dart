import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:meetloop/features/profile/domain/entities/profile_entity.dart';
import 'package:meetloop/features/profile/domain/repositories/profile_repository.dart';
import 'package:meetloop/features/profile/presentation/providers/profile_provider.dart';

class MockProfileRepository extends Mock implements ProfileRepository {
  @override
  Future<ProfileEntity> getProfile(String uid) {
    return super.noSuchMethod(
      Invocation.method(#getProfile, [uid]),
      returnValue: Future.value(ProfileEntity(uid: uid, displayName: 'Test User')),
      returnValueForMissingStub: Future.value(ProfileEntity(uid: uid, displayName: 'Test User')),
    ) as Future<ProfileEntity>;
  }

  @override
  Future<void> updateProfile(ProfileEntity profile) {
    return super.noSuchMethod(
      Invocation.method(#updateProfile, [profile]),
      returnValue: Future.value(),
      returnValueForMissingStub: Future.value(),
    ) as Future<void>;
  }
}

void main() {
  late MockProfileRepository mockProfileRepository;
  late ProfileController profileController;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    profileController = ProfileController(mockProfileRepository);
  });

  group('ProfileController tests', () {
    test('initial state is default ProfileControllerState', () {
      expect(profileController.state.isLoading, false);
      expect(profileController.state.errorMessage, null);
      expect(profileController.state.profile, null);
    });

    test('fetchProfile sets isLoading and updates profile on success', () async {
      const testUid = 'user_abc';
      const testProfile = ProfileEntity(uid: testUid, displayName: 'Alice');

      when(mockProfileRepository.getProfile(testUid))
          .thenAnswer((_) async => testProfile);

      final future = profileController.fetchProfile(testUid);

      expect(profileController.state.isLoading, true);

      await future;

      expect(profileController.state.isLoading, false);
      expect(profileController.state.profile, testProfile);
      expect(profileController.state.errorMessage, null);
    });

    test('fetchProfile sets errorMessage on failure', () async {
      when(mockProfileRepository.getProfile('invalid_uid'))
          .thenThrow(Exception('No profile found'));

      await profileController.fetchProfile('invalid_uid');

      expect(profileController.state.isLoading, false);
      expect(profileController.state.profile, null);
      expect(profileController.state.errorMessage, contains('No profile found'));
    });
  });
}
