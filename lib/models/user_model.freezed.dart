// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get userId => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError; // unique handle
  String get displayName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String get passwordHash => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  bool? get isCountryPublic => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  bool? get isAgePublic => throw _privateConstructorUsedError;
  String? get address =>
      throw _privateConstructorUsedError; // store only if necessary and encrypt
  String? get bio => throw _privateConstructorUsedError;
  List<String>? get languages => throw _privateConstructorUsedError;
  List<String>? get interests => throw _privateConstructorUsedError;
  String? get profilePictureUrl => throw _privateConstructorUsedError;
  List<String>? get friends => throw _privateConstructorUsedError;
  List<String>? get blockedUsers => throw _privateConstructorUsedError;
  List<String>? get lettersSent => throw _privateConstructorUsedError;
  List<String>? get lettersReceived => throw _privateConstructorUsedError;
  List<String>? get purchases => throw _privateConstructorUsedError;
  List<String>? get badges => throw _privateConstructorUsedError;
  DateTime? get lastActive => throw _privateConstructorUsedError;
  bool? get isVerified => throw _privateConstructorUsedError;
  String? get themePreference => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call({
    String userId,
    String username,
    String displayName,
    String email,
    String? phone,
    String passwordHash,
    String? country,
    bool? isCountryPublic,
    int? age,
    bool? isAgePublic,
    String? address,
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
    String? themePreference,
  });
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? displayName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? passwordHash = null,
    Object? country = freezed,
    Object? isCountryPublic = freezed,
    Object? age = freezed,
    Object? isAgePublic = freezed,
    Object? address = freezed,
    Object? bio = freezed,
    Object? languages = freezed,
    Object? interests = freezed,
    Object? profilePictureUrl = freezed,
    Object? friends = freezed,
    Object? blockedUsers = freezed,
    Object? lettersSent = freezed,
    Object? lettersReceived = freezed,
    Object? purchases = freezed,
    Object? badges = freezed,
    Object? lastActive = freezed,
    Object? isVerified = freezed,
    Object? themePreference = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            displayName: null == displayName
                ? _value.displayName
                : displayName // ignore: cast_nullable_to_non_nullable
                      as String,
            email: null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            passwordHash: null == passwordHash
                ? _value.passwordHash
                : passwordHash // ignore: cast_nullable_to_non_nullable
                      as String,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            isCountryPublic: freezed == isCountryPublic
                ? _value.isCountryPublic
                : isCountryPublic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            age: freezed == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int?,
            isAgePublic: freezed == isAgePublic
                ? _value.isAgePublic
                : isAgePublic // ignore: cast_nullable_to_non_nullable
                      as bool?,
            address: freezed == address
                ? _value.address
                : address // ignore: cast_nullable_to_non_nullable
                      as String?,
            bio: freezed == bio
                ? _value.bio
                : bio // ignore: cast_nullable_to_non_nullable
                      as String?,
            languages: freezed == languages
                ? _value.languages
                : languages // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            interests: freezed == interests
                ? _value.interests
                : interests // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            profilePictureUrl: freezed == profilePictureUrl
                ? _value.profilePictureUrl
                : profilePictureUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            friends: freezed == friends
                ? _value.friends
                : friends // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            blockedUsers: freezed == blockedUsers
                ? _value.blockedUsers
                : blockedUsers // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            lettersSent: freezed == lettersSent
                ? _value.lettersSent
                : lettersSent // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            lettersReceived: freezed == lettersReceived
                ? _value.lettersReceived
                : lettersReceived // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            purchases: freezed == purchases
                ? _value.purchases
                : purchases // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            badges: freezed == badges
                ? _value.badges
                : badges // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            lastActive: freezed == lastActive
                ? _value.lastActive
                : lastActive // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            isVerified: freezed == isVerified
                ? _value.isVerified
                : isVerified // ignore: cast_nullable_to_non_nullable
                      as bool?,
            themePreference: freezed == themePreference
                ? _value.themePreference
                : themePreference // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
    _$UserModelImpl value,
    $Res Function(_$UserModelImpl) then,
  ) = __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String userId,
    String username,
    String displayName,
    String email,
    String? phone,
    String passwordHash,
    String? country,
    bool? isCountryPublic,
    int? age,
    bool? isAgePublic,
    String? address,
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
    String? themePreference,
  });
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
    _$UserModelImpl _value,
    $Res Function(_$UserModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? username = null,
    Object? displayName = null,
    Object? email = null,
    Object? phone = freezed,
    Object? passwordHash = null,
    Object? country = freezed,
    Object? isCountryPublic = freezed,
    Object? age = freezed,
    Object? isAgePublic = freezed,
    Object? address = freezed,
    Object? bio = freezed,
    Object? languages = freezed,
    Object? interests = freezed,
    Object? profilePictureUrl = freezed,
    Object? friends = freezed,
    Object? blockedUsers = freezed,
    Object? lettersSent = freezed,
    Object? lettersReceived = freezed,
    Object? purchases = freezed,
    Object? badges = freezed,
    Object? lastActive = freezed,
    Object? isVerified = freezed,
    Object? themePreference = freezed,
  }) {
    return _then(
      _$UserModelImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        displayName: null == displayName
            ? _value.displayName
            : displayName // ignore: cast_nullable_to_non_nullable
                  as String,
        email: null == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        passwordHash: null == passwordHash
            ? _value.passwordHash
            : passwordHash // ignore: cast_nullable_to_non_nullable
                  as String,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        isCountryPublic: freezed == isCountryPublic
            ? _value.isCountryPublic
            : isCountryPublic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        age: freezed == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int?,
        isAgePublic: freezed == isAgePublic
            ? _value.isAgePublic
            : isAgePublic // ignore: cast_nullable_to_non_nullable
                  as bool?,
        address: freezed == address
            ? _value.address
            : address // ignore: cast_nullable_to_non_nullable
                  as String?,
        bio: freezed == bio
            ? _value.bio
            : bio // ignore: cast_nullable_to_non_nullable
                  as String?,
        languages: freezed == languages
            ? _value._languages
            : languages // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        interests: freezed == interests
            ? _value._interests
            : interests // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        profilePictureUrl: freezed == profilePictureUrl
            ? _value.profilePictureUrl
            : profilePictureUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        friends: freezed == friends
            ? _value._friends
            : friends // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        blockedUsers: freezed == blockedUsers
            ? _value._blockedUsers
            : blockedUsers // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        lettersSent: freezed == lettersSent
            ? _value._lettersSent
            : lettersSent // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        lettersReceived: freezed == lettersReceived
            ? _value._lettersReceived
            : lettersReceived // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        purchases: freezed == purchases
            ? _value._purchases
            : purchases // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        badges: freezed == badges
            ? _value._badges
            : badges // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        lastActive: freezed == lastActive
            ? _value.lastActive
            : lastActive // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        isVerified: freezed == isVerified
            ? _value.isVerified
            : isVerified // ignore: cast_nullable_to_non_nullable
                  as bool?,
        themePreference: freezed == themePreference
            ? _value.themePreference
            : themePreference // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl({
    required this.userId,
    required this.username,
    required this.displayName,
    required this.email,
    this.phone,
    required this.passwordHash,
    this.country,
    this.isCountryPublic,
    this.age,
    this.isAgePublic,
    this.address,
    this.bio,
    final List<String>? languages,
    final List<String>? interests,
    this.profilePictureUrl,
    final List<String>? friends,
    final List<String>? blockedUsers,
    final List<String>? lettersSent,
    final List<String>? lettersReceived,
    final List<String>? purchases,
    final List<String>? badges,
    this.lastActive,
    this.isVerified,
    this.themePreference,
  }) : _languages = languages,
       _interests = interests,
       _friends = friends,
       _blockedUsers = blockedUsers,
       _lettersSent = lettersSent,
       _lettersReceived = lettersReceived,
       _purchases = purchases,
       _badges = badges;

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String username;
  // unique handle
  @override
  final String displayName;
  @override
  final String email;
  @override
  final String? phone;
  @override
  final String passwordHash;
  @override
  final String? country;
  @override
  final bool? isCountryPublic;
  @override
  final int? age;
  @override
  final bool? isAgePublic;
  @override
  final String? address;
  // store only if necessary and encrypt
  @override
  final String? bio;
  final List<String>? _languages;
  @override
  List<String>? get languages {
    final value = _languages;
    if (value == null) return null;
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _interests;
  @override
  List<String>? get interests {
    final value = _interests;
    if (value == null) return null;
    if (_interests is EqualUnmodifiableListView) return _interests;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? profilePictureUrl;
  final List<String>? _friends;
  @override
  List<String>? get friends {
    final value = _friends;
    if (value == null) return null;
    if (_friends is EqualUnmodifiableListView) return _friends;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _blockedUsers;
  @override
  List<String>? get blockedUsers {
    final value = _blockedUsers;
    if (value == null) return null;
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _lettersSent;
  @override
  List<String>? get lettersSent {
    final value = _lettersSent;
    if (value == null) return null;
    if (_lettersSent is EqualUnmodifiableListView) return _lettersSent;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _lettersReceived;
  @override
  List<String>? get lettersReceived {
    final value = _lettersReceived;
    if (value == null) return null;
    if (_lettersReceived is EqualUnmodifiableListView) return _lettersReceived;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _purchases;
  @override
  List<String>? get purchases {
    final value = _purchases;
    if (value == null) return null;
    if (_purchases is EqualUnmodifiableListView) return _purchases;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _badges;
  @override
  List<String>? get badges {
    final value = _badges;
    if (value == null) return null;
    if (_badges is EqualUnmodifiableListView) return _badges;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final DateTime? lastActive;
  @override
  final bool? isVerified;
  @override
  final String? themePreference;

  @override
  String toString() {
    return 'UserModel(userId: $userId, username: $username, displayName: $displayName, email: $email, phone: $phone, passwordHash: $passwordHash, country: $country, isCountryPublic: $isCountryPublic, age: $age, isAgePublic: $isAgePublic, address: $address, bio: $bio, languages: $languages, interests: $interests, profilePictureUrl: $profilePictureUrl, friends: $friends, blockedUsers: $blockedUsers, lettersSent: $lettersSent, lettersReceived: $lettersReceived, purchases: $purchases, badges: $badges, lastActive: $lastActive, isVerified: $isVerified, themePreference: $themePreference)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.passwordHash, passwordHash) ||
                other.passwordHash == passwordHash) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.isCountryPublic, isCountryPublic) ||
                other.isCountryPublic == isCountryPublic) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.isAgePublic, isAgePublic) ||
                other.isAgePublic == isAgePublic) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            const DeepCollectionEquality().equals(
              other._languages,
              _languages,
            ) &&
            const DeepCollectionEquality().equals(
              other._interests,
              _interests,
            ) &&
            (identical(other.profilePictureUrl, profilePictureUrl) ||
                other.profilePictureUrl == profilePictureUrl) &&
            const DeepCollectionEquality().equals(other._friends, _friends) &&
            const DeepCollectionEquality().equals(
              other._blockedUsers,
              _blockedUsers,
            ) &&
            const DeepCollectionEquality().equals(
              other._lettersSent,
              _lettersSent,
            ) &&
            const DeepCollectionEquality().equals(
              other._lettersReceived,
              _lettersReceived,
            ) &&
            const DeepCollectionEquality().equals(
              other._purchases,
              _purchases,
            ) &&
            const DeepCollectionEquality().equals(other._badges, _badges) &&
            (identical(other.lastActive, lastActive) ||
                other.lastActive == lastActive) &&
            (identical(other.isVerified, isVerified) ||
                other.isVerified == isVerified) &&
            (identical(other.themePreference, themePreference) ||
                other.themePreference == themePreference));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    userId,
    username,
    displayName,
    email,
    phone,
    passwordHash,
    country,
    isCountryPublic,
    age,
    isAgePublic,
    address,
    bio,
    const DeepCollectionEquality().hash(_languages),
    const DeepCollectionEquality().hash(_interests),
    profilePictureUrl,
    const DeepCollectionEquality().hash(_friends),
    const DeepCollectionEquality().hash(_blockedUsers),
    const DeepCollectionEquality().hash(_lettersSent),
    const DeepCollectionEquality().hash(_lettersReceived),
    const DeepCollectionEquality().hash(_purchases),
    const DeepCollectionEquality().hash(_badges),
    lastActive,
    isVerified,
    themePreference,
  ]);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(this);
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel({
    required final String userId,
    required final String username,
    required final String displayName,
    required final String email,
    final String? phone,
    required final String passwordHash,
    final String? country,
    final bool? isCountryPublic,
    final int? age,
    final bool? isAgePublic,
    final String? address,
    final String? bio,
    final List<String>? languages,
    final List<String>? interests,
    final String? profilePictureUrl,
    final List<String>? friends,
    final List<String>? blockedUsers,
    final List<String>? lettersSent,
    final List<String>? lettersReceived,
    final List<String>? purchases,
    final List<String>? badges,
    final DateTime? lastActive,
    final bool? isVerified,
    final String? themePreference,
  }) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get username; // unique handle
  @override
  String get displayName;
  @override
  String get email;
  @override
  String? get phone;
  @override
  String get passwordHash;
  @override
  String? get country;
  @override
  bool? get isCountryPublic;
  @override
  int? get age;
  @override
  bool? get isAgePublic;
  @override
  String? get address; // store only if necessary and encrypt
  @override
  String? get bio;
  @override
  List<String>? get languages;
  @override
  List<String>? get interests;
  @override
  String? get profilePictureUrl;
  @override
  List<String>? get friends;
  @override
  List<String>? get blockedUsers;
  @override
  List<String>? get lettersSent;
  @override
  List<String>? get lettersReceived;
  @override
  List<String>? get purchases;
  @override
  List<String>? get badges;
  @override
  DateTime? get lastActive;
  @override
  bool? get isVerified;
  @override
  String? get themePreference;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
