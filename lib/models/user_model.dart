import 'package:freezed_annotation/freezed_annotation.dart';
part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String username, // unique handle
    required String displayName,
    required String email,
    String? phone,
    required String passwordHash,

    String? country,
    bool? isCountryPublic,
    int? age,
    bool? isAgePublic,
    String? address, // store only if necessary and encrypt

    String? bio,
    List<String>? languages,
    List<String>? interests,
    String? profilePictureUrl,

    List<String>? friends,
    List<String>? blockedUsers,

    List<String>? lettersSent,
    List<String>? lettersReceived,

    List<String>? purchases,
    List<String>? badges,

    DateTime? lastActive,
    bool? isVerified,
    String? themePreference, // "light" | "dark" | "system"

  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}