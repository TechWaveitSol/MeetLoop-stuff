import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid;
  final String? email;
  final String? phoneNumber;
  final String? displayName;
  final String? photoURL;
  final String? providerId;
  final DateTime? createdAt;
  final DateTime? lastSignInAt;
  final bool isEmailVerified;
  final bool isPhoneNumberVerified;
  final List<String> linkedProviders;
  final List<String> activeDevices;

  const UserEntity({
    required this.uid,
    this.email,
    this.phoneNumber,
    this.displayName,
    this.photoURL,
    this.providerId,
    this.createdAt,
    this.lastSignInAt,
    this.isEmailVerified = false,
    this.isPhoneNumberVerified = false,
    this.linkedProviders = const [],
    this.activeDevices = const [],
  });

  UserEntity copyWith({
    String? uid,
    String? email,
    String? phoneNumber,
    String? displayName,
    String? photoURL,
    String? providerId,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    bool? isEmailVerified,
    bool? isPhoneNumberVerified,
    List<String>? linkedProviders,
    List<String>? activeDevices,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      displayName: displayName ?? this.displayName,
      photoURL: photoURL ?? this.photoURL,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
      lastSignInAt: lastSignInAt ?? this.lastSignInAt,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      isPhoneNumberVerified: isPhoneNumberVerified ?? this.isPhoneNumberVerified,
      linkedProviders: linkedProviders ?? this.linkedProviders,
      activeDevices: activeDevices ?? this.activeDevices,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        email,
        phoneNumber,
        displayName,
        photoURL,
        providerId,
        createdAt,
        lastSignInAt,
        isEmailVerified,
        isPhoneNumberVerified,
        linkedProviders,
        activeDevices,
      ];
}
