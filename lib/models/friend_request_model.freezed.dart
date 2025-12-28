// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FriendRequestModel _$FriendRequestModelFromJson(Map<String, dynamic> json) {
  return _FriendRequestModel.fromJson(json);
}

/// @nodoc
mixin _$FriendRequestModel {
  String get requestId => throw _privateConstructorUsedError;
  String get fromUserId => throw _privateConstructorUsedError;
  String get toUserId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // 'pending', 'accepted', 'rejected'
  DateTime? get respondedAt => throw _privateConstructorUsedError;

  /// Serializes this FriendRequestModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestModelCopyWith<FriendRequestModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestModelCopyWith<$Res> {
  factory $FriendRequestModelCopyWith(
    FriendRequestModel value,
    $Res Function(FriendRequestModel) then,
  ) = _$FriendRequestModelCopyWithImpl<$Res, FriendRequestModel>;
  @useResult
  $Res call({
    String requestId,
    String fromUserId,
    String toUserId,
    DateTime createdAt,
    String status,
    DateTime? respondedAt,
  });
}

/// @nodoc
class _$FriendRequestModelCopyWithImpl<$Res, $Val extends FriendRequestModel>
    implements $FriendRequestModelCopyWith<$Res> {
  _$FriendRequestModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? createdAt = null,
    Object? status = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            requestId: null == requestId
                ? _value.requestId
                : requestId // ignore: cast_nullable_to_non_nullable
                      as String,
            fromUserId: null == fromUserId
                ? _value.fromUserId
                : fromUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            toUserId: null == toUserId
                ? _value.toUserId
                : toUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendRequestModelImplCopyWith<$Res>
    implements $FriendRequestModelCopyWith<$Res> {
  factory _$$FriendRequestModelImplCopyWith(
    _$FriendRequestModelImpl value,
    $Res Function(_$FriendRequestModelImpl) then,
  ) = __$$FriendRequestModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String requestId,
    String fromUserId,
    String toUserId,
    DateTime createdAt,
    String status,
    DateTime? respondedAt,
  });
}

/// @nodoc
class __$$FriendRequestModelImplCopyWithImpl<$Res>
    extends _$FriendRequestModelCopyWithImpl<$Res, _$FriendRequestModelImpl>
    implements _$$FriendRequestModelImplCopyWith<$Res> {
  __$$FriendRequestModelImplCopyWithImpl(
    _$FriendRequestModelImpl _value,
    $Res Function(_$FriendRequestModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? requestId = null,
    Object? fromUserId = null,
    Object? toUserId = null,
    Object? createdAt = null,
    Object? status = null,
    Object? respondedAt = freezed,
  }) {
    return _then(
      _$FriendRequestModelImpl(
        requestId: null == requestId
            ? _value.requestId
            : requestId // ignore: cast_nullable_to_non_nullable
                  as String,
        fromUserId: null == fromUserId
            ? _value.fromUserId
            : fromUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        toUserId: null == toUserId
            ? _value.toUserId
            : toUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendRequestModelImpl implements _FriendRequestModel {
  const _$FriendRequestModelImpl({
    required this.requestId,
    required this.fromUserId,
    required this.toUserId,
    required this.createdAt,
    this.status = 'pending',
    this.respondedAt,
  });

  factory _$FriendRequestModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRequestModelImplFromJson(json);

  @override
  final String requestId;
  @override
  final String fromUserId;
  @override
  final String toUserId;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String status;
  // 'pending', 'accepted', 'rejected'
  @override
  final DateTime? respondedAt;

  @override
  String toString() {
    return 'FriendRequestModel(requestId: $requestId, fromUserId: $fromUserId, toUserId: $toUserId, createdAt: $createdAt, status: $status, respondedAt: $respondedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestModelImpl &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            (identical(other.fromUserId, fromUserId) ||
                other.fromUserId == fromUserId) &&
            (identical(other.toUserId, toUserId) ||
                other.toUserId == toUserId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    requestId,
    fromUserId,
    toUserId,
    createdAt,
    status,
    respondedAt,
  );

  /// Create a copy of FriendRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestModelImplCopyWith<_$FriendRequestModelImpl> get copyWith =>
      __$$FriendRequestModelImplCopyWithImpl<_$FriendRequestModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRequestModelImplToJson(this);
  }
}

abstract class _FriendRequestModel implements FriendRequestModel {
  const factory _FriendRequestModel({
    required final String requestId,
    required final String fromUserId,
    required final String toUserId,
    required final DateTime createdAt,
    final String status,
    final DateTime? respondedAt,
  }) = _$FriendRequestModelImpl;

  factory _FriendRequestModel.fromJson(Map<String, dynamic> json) =
      _$FriendRequestModelImpl.fromJson;

  @override
  String get requestId;
  @override
  String get fromUserId;
  @override
  String get toUserId;
  @override
  DateTime get createdAt;
  @override
  String get status; // 'pending', 'accepted', 'rejected'
  @override
  DateTime? get respondedAt;

  /// Create a copy of FriendRequestModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestModelImplCopyWith<_$FriendRequestModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
