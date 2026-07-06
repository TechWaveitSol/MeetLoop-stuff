import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required String uid,
    String? email,
    String? phoneNumber,
    String? displayName,
    String? photoURL,
    String? providerId,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    bool isEmailVerified = false,
    bool isPhoneNumberVerified = false,
    List<String> linkedProviders = const [],
    List<String> activeDevices = const [],
  }) : super(
          uid: uid,
          email: email,
          phoneNumber: phoneNumber,
          displayName: displayName,
          photoURL: photoURL,
          providerId: providerId,
          createdAt: createdAt,
          lastSignInAt: lastSignInAt,
          isEmailVerified: isEmailVerified,
          isPhoneNumberVerified: isPhoneNumberVerified,
          linkedProviders: linkedProviders,
          activeDevices: activeDevices,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] as String,
      email: json['email'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      displayName: json['displayName'] as String?,
      photoURL: json['photoURL'] as String?,
      providerId: json['providerId'] as String?,
      createdAt: json['createdAt'] != null 
          ? DateTime.parse(json['createdAt'] as String) 
          : null,
      lastSignInAt: json['lastSignInAt'] != null 
          ? DateTime.parse(json['lastSignInAt'] as String) 
          : null,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      isPhoneNumberVerified: json['isPhoneNumberVerified'] as bool? ?? false,
      linkedProviders: List<String>.from(json['linkedProviders'] ?? []),
      activeDevices: List<String>.from(json['activeDevices'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'phoneNumber': phoneNumber,
      'displayName': displayName,
      'photoURL': photoURL,
      'providerId': providerId,
      'createdAt': createdAt?.toIso8601String(),
      'lastSignInAt': lastSignInAt?.toIso8601String(),
      'isEmailVerified': isEmailVerified,
      'isPhoneNumberVerified': isPhoneNumberVerified,
      'linkedProviders': linkedProviders,
      'activeDevices': activeDevices,
    };
  }
}
