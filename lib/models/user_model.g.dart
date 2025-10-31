// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
      displayName: json['displayName'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String?,
      passwordHash: json['passwordHash'] as String,
      country: json['country'] as String?,
      isCountryPublic: json['isCountryPublic'] as bool?,
      age: (json['age'] as num?)?.toInt(),
      isAgePublic: json['isAgePublic'] as bool?,
      address: json['address'] as String?,
      bio: json['bio'] as String?,
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      profilePictureUrl: json['profilePictureUrl'] as String?,
      friends: (json['friends'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      blockedUsers: (json['blockedUsers'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lettersSent: (json['lettersSent'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lettersReceived: (json['lettersReceived'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      purchases: (json['purchases'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      badges: (json['badges'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastActive: json['lastActive'] == null
          ? null
          : DateTime.parse(json['lastActive'] as String),
      isVerified: json['isVerified'] as bool?,
      themePreference: json['themePreference'] as String?,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'displayName': instance.displayName,
      'email': instance.email,
      'phone': instance.phone,
      'passwordHash': instance.passwordHash,
      'country': instance.country,
      'isCountryPublic': instance.isCountryPublic,
      'age': instance.age,
      'isAgePublic': instance.isAgePublic,
      'address': instance.address,
      'bio': instance.bio,
      'languages': instance.languages,
      'interests': instance.interests,
      'profilePictureUrl': instance.profilePictureUrl,
      'friends': instance.friends,
      'blockedUsers': instance.blockedUsers,
      'lettersSent': instance.lettersSent,
      'lettersReceived': instance.lettersReceived,
      'purchases': instance.purchases,
      'badges': instance.badges,
      'lastActive': instance.lastActive?.toIso8601String(),
      'isVerified': instance.isVerified,
      'themePreference': instance.themePreference,
    };
