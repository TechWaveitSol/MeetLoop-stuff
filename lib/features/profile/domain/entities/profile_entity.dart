import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  final String uid;
  final String displayName;
  final String username;
  final String bio;
  final String gender;
  final String pronouns;
  final DateTime? dateOfBirth;
  final bool isAgeVerified;
  final double? height;
  final List<String> languages;
  final String relationshipStatus;
  final String occupation;
  final String education;
  final String religion;
  final String smokingPreference; // 'Yes' | 'No' | 'Sometimes' etc.
  final String drinkingPreference;
  final List<String> pets;
  final List<String> hobbies;
  final List<String> interests;
  final List<String> favoriteMusic;
  final List<String> favoriteMovies;
  final List<String> sports;
  final List<String> photos;
  final String? profileVideoUrl;
  final bool verificationBadge;
  final String personalityType; // e.g. INFJ, ENFP
  final Map<String, dynamic> privacySettings;
  final Map<String, dynamic> notificationSettings;
  final Map<String, dynamic> locationSettings;
  final List<String> blockedUsers;
  final List<String> mutedUsers;
  final List<String> friends;
  final int profileCompletionPercentage;

  const ProfileEntity({
    required this.uid,
    required this.displayName,
    this.username = '',
    this.bio = '',
    this.gender = '',
    this.pronouns = '',
    this.dateOfBirth,
    this.isAgeVerified = false,
    this.height,
    this.languages = const [],
    this.relationshipStatus = 'Single',
    this.occupation = '',
    this.education = '',
    this.religion = '',
    this.smokingPreference = 'No',
    this.drinkingPreference = 'No',
    this.pets = const [],
    this.hobbies = const [],
    this.interests = const [],
    this.favoriteMusic = const [],
    this.favoriteMovies = const [],
    this.sports = const [],
    this.photos = const [],
    this.profileVideoUrl,
    this.verificationBadge = false,
    this.personalityType = '',
    this.privacySettings = const {},
    this.notificationSettings = const {},
    this.locationSettings = const {},
    this.blockedUsers = const [],
    this.mutedUsers = const [],
    this.friends = const [],
    this.profileCompletionPercentage = 0,
  });

  ProfileEntity copyWith({
    String? uid,
    String? displayName,
    String? username,
    String? bio,
    String? gender,
    String? pronouns,
    DateTime? dateOfBirth,
    bool? isAgeVerified,
    double? height,
    List<String>? languages,
    String? relationshipStatus,
    String? occupation,
    String? education,
    String? religion,
    String? smokingPreference,
    String? drinkingPreference,
    List<String>? pets,
    List<String>? hobbies,
    List<String>? interests,
    List<String>? favoriteMusic,
    List<String>? favoriteMovies,
    List<String>? sports,
    List<String>? photos,
    String? profileVideoUrl,
    bool? verificationBadge,
    String? personalityType,
    Map<String, dynamic>? privacySettings,
    Map<String, dynamic>? notificationSettings,
    Map<String, dynamic>? locationSettings,
    List<String>? blockedUsers,
    List<String>? mutedUsers,
    List<String>? friends,
    int? profileCompletionPercentage,
  }) {
    return ProfileEntity(
      uid: uid ?? this.uid,
      displayName: displayName ?? this.displayName,
      username: username ?? this.username,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      pronouns: pronouns ?? this.pronouns,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isAgeVerified: isAgeVerified ?? this.isAgeVerified,
      height: height ?? this.height,
      languages: languages ?? this.languages,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
      occupation: occupation ?? this.occupation,
      education: education ?? this.education,
      religion: religion ?? this.religion,
      smokingPreference: smokingPreference ?? this.smokingPreference,
      drinkingPreference: drinkingPreference ?? this.drinkingPreference,
      pets: pets ?? this.pets,
      hobbies: hobbies ?? this.hobbies,
      interests: interests ?? this.interests,
      favoriteMusic: favoriteMusic ?? this.favoriteMusic,
      favoriteMovies: favoriteMovies ?? this.favoriteMovies,
      sports: sports ?? this.sports,
      photos: photos ?? this.photos,
      profileVideoUrl: profileVideoUrl ?? this.profileVideoUrl,
      verificationBadge: verificationBadge ?? this.verificationBadge,
      personalityType: personalityType ?? this.personalityType,
      privacySettings: privacySettings ?? this.privacySettings,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      locationSettings: locationSettings ?? this.locationSettings,
      blockedUsers: blockedUsers ?? this.blockedUsers,
      mutedUsers: mutedUsers ?? this.mutedUsers,
      friends: friends ?? this.friends,
      profileCompletionPercentage: profileCompletionPercentage ?? this.profileCompletionPercentage,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        displayName,
        username,
        bio,
        gender,
        pronouns,
        dateOfBirth,
        isAgeVerified,
        height,
        languages,
        relationshipStatus,
        occupation,
        education,
        religion,
        smokingPreference,
        drinkingPreference,
        pets,
        hobbies,
        interests,
        favoriteMusic,
        favoriteMovies,
        sports,
        photos,
        profileVideoUrl,
        verificationBadge,
        personalityType,
        privacySettings,
        notificationSettings,
        locationSettings,
        blockedUsers,
        mutedUsers,
        friends,
        profileCompletionPercentage,
      ];
}
