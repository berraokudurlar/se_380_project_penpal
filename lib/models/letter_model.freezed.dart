// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'letter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

LetterModel _$LetterModelFromJson(Map<String, dynamic> json) {
  return _LetterModel.fromJson(json);
}

/// @nodoc
mixin _$LetterModel {
  String get letterId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get receiverId => throw _privateConstructorUsedError;
  DateTime get sentDate => throw _privateConstructorUsedError;
  DateTime? get receivedDate => throw _privateConstructorUsedError;
  String get status =>
      throw _privateConstructorUsedError; // draft, sent, scheduled, delivered?
  String? get locationSentFrom => throw _privateConstructorUsedError;
  String? get locationReceived => throw _privateConstructorUsedError;
  double? get distanceKm => throw _privateConstructorUsedError;
  double? get deliveryTimeHours => throw _privateConstructorUsedError;
  String get contentText => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customizations =>
      throw _privateConstructorUsedError;
  List<String>? get attachments => throw _privateConstructorUsedError;
  bool? get isEncrypted => throw _privateConstructorUsedError;
  String? get replyToLetterId => throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;

  /// Serializes this LetterModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LetterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LetterModelCopyWith<LetterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LetterModelCopyWith<$Res> {
  factory $LetterModelCopyWith(
    LetterModel value,
    $Res Function(LetterModel) then,
  ) = _$LetterModelCopyWithImpl<$Res, LetterModel>;
  @useResult
  $Res call({
    String letterId,
    String senderId,
    String receiverId,
    DateTime sentDate,
    DateTime? receivedDate,
    String status,
    String? locationSentFrom,
    String? locationReceived,
    double? distanceKm,
    double? deliveryTimeHours,
    String contentText,
    Map<String, dynamic>? customizations,
    List<String>? attachments,
    bool? isEncrypted,
    String? replyToLetterId,
    bool deleted,
  });
}

/// @nodoc
class _$LetterModelCopyWithImpl<$Res, $Val extends LetterModel>
    implements $LetterModelCopyWith<$Res> {
  _$LetterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LetterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letterId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? sentDate = null,
    Object? receivedDate = freezed,
    Object? status = null,
    Object? locationSentFrom = freezed,
    Object? locationReceived = freezed,
    Object? distanceKm = freezed,
    Object? deliveryTimeHours = freezed,
    Object? contentText = null,
    Object? customizations = freezed,
    Object? attachments = freezed,
    Object? isEncrypted = freezed,
    Object? replyToLetterId = freezed,
    Object? deleted = null,
  }) {
    return _then(
      _value.copyWith(
            letterId: null == letterId
                ? _value.letterId
                : letterId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            receiverId: null == receiverId
                ? _value.receiverId
                : receiverId // ignore: cast_nullable_to_non_nullable
                      as String,
            sentDate: null == sentDate
                ? _value.sentDate
                : sentDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            receivedDate: freezed == receivedDate
                ? _value.receivedDate
                : receivedDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            locationSentFrom: freezed == locationSentFrom
                ? _value.locationSentFrom
                : locationSentFrom // ignore: cast_nullable_to_non_nullable
                      as String?,
            locationReceived: freezed == locationReceived
                ? _value.locationReceived
                : locationReceived // ignore: cast_nullable_to_non_nullable
                      as String?,
            distanceKm: freezed == distanceKm
                ? _value.distanceKm
                : distanceKm // ignore: cast_nullable_to_non_nullable
                      as double?,
            deliveryTimeHours: freezed == deliveryTimeHours
                ? _value.deliveryTimeHours
                : deliveryTimeHours // ignore: cast_nullable_to_non_nullable
                      as double?,
            contentText: null == contentText
                ? _value.contentText
                : contentText // ignore: cast_nullable_to_non_nullable
                      as String,
            customizations: freezed == customizations
                ? _value.customizations
                : customizations // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
            attachments: freezed == attachments
                ? _value.attachments
                : attachments // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            isEncrypted: freezed == isEncrypted
                ? _value.isEncrypted
                : isEncrypted // ignore: cast_nullable_to_non_nullable
                      as bool?,
            replyToLetterId: freezed == replyToLetterId
                ? _value.replyToLetterId
                : replyToLetterId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deleted: null == deleted
                ? _value.deleted
                : deleted // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LetterModelImplCopyWith<$Res>
    implements $LetterModelCopyWith<$Res> {
  factory _$$LetterModelImplCopyWith(
    _$LetterModelImpl value,
    $Res Function(_$LetterModelImpl) then,
  ) = __$$LetterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String letterId,
    String senderId,
    String receiverId,
    DateTime sentDate,
    DateTime? receivedDate,
    String status,
    String? locationSentFrom,
    String? locationReceived,
    double? distanceKm,
    double? deliveryTimeHours,
    String contentText,
    Map<String, dynamic>? customizations,
    List<String>? attachments,
    bool? isEncrypted,
    String? replyToLetterId,
    bool deleted,
  });
}

/// @nodoc
class __$$LetterModelImplCopyWithImpl<$Res>
    extends _$LetterModelCopyWithImpl<$Res, _$LetterModelImpl>
    implements _$$LetterModelImplCopyWith<$Res> {
  __$$LetterModelImplCopyWithImpl(
    _$LetterModelImpl _value,
    $Res Function(_$LetterModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LetterModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? letterId = null,
    Object? senderId = null,
    Object? receiverId = null,
    Object? sentDate = null,
    Object? receivedDate = freezed,
    Object? status = null,
    Object? locationSentFrom = freezed,
    Object? locationReceived = freezed,
    Object? distanceKm = freezed,
    Object? deliveryTimeHours = freezed,
    Object? contentText = null,
    Object? customizations = freezed,
    Object? attachments = freezed,
    Object? isEncrypted = freezed,
    Object? replyToLetterId = freezed,
    Object? deleted = null,
  }) {
    return _then(
      _$LetterModelImpl(
        letterId: null == letterId
            ? _value.letterId
            : letterId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        receiverId: null == receiverId
            ? _value.receiverId
            : receiverId // ignore: cast_nullable_to_non_nullable
                  as String,
        sentDate: null == sentDate
            ? _value.sentDate
            : sentDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        receivedDate: freezed == receivedDate
            ? _value.receivedDate
            : receivedDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        locationSentFrom: freezed == locationSentFrom
            ? _value.locationSentFrom
            : locationSentFrom // ignore: cast_nullable_to_non_nullable
                  as String?,
        locationReceived: freezed == locationReceived
            ? _value.locationReceived
            : locationReceived // ignore: cast_nullable_to_non_nullable
                  as String?,
        distanceKm: freezed == distanceKm
            ? _value.distanceKm
            : distanceKm // ignore: cast_nullable_to_non_nullable
                  as double?,
        deliveryTimeHours: freezed == deliveryTimeHours
            ? _value.deliveryTimeHours
            : deliveryTimeHours // ignore: cast_nullable_to_non_nullable
                  as double?,
        contentText: null == contentText
            ? _value.contentText
            : contentText // ignore: cast_nullable_to_non_nullable
                  as String,
        customizations: freezed == customizations
            ? _value._customizations
            : customizations // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
        attachments: freezed == attachments
            ? _value._attachments
            : attachments // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        isEncrypted: freezed == isEncrypted
            ? _value.isEncrypted
            : isEncrypted // ignore: cast_nullable_to_non_nullable
                  as bool?,
        replyToLetterId: freezed == replyToLetterId
            ? _value.replyToLetterId
            : replyToLetterId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deleted: null == deleted
            ? _value.deleted
            : deleted // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LetterModelImpl implements _LetterModel {
  const _$LetterModelImpl({
    required this.letterId,
    required this.senderId,
    required this.receiverId,
    required this.sentDate,
    this.receivedDate,
    this.status = 'draft',
    this.locationSentFrom,
    this.locationReceived,
    this.distanceKm,
    this.deliveryTimeHours,
    required this.contentText,
    final Map<String, dynamic>? customizations,
    final List<String>? attachments,
    this.isEncrypted,
    this.replyToLetterId,
    this.deleted = false,
  }) : _customizations = customizations,
       _attachments = attachments;

  factory _$LetterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LetterModelImplFromJson(json);

  @override
  final String letterId;
  @override
  final String senderId;
  @override
  final String receiverId;
  @override
  final DateTime sentDate;
  @override
  final DateTime? receivedDate;
  @override
  @JsonKey()
  final String status;
  // draft, sent, scheduled, delivered?
  @override
  final String? locationSentFrom;
  @override
  final String? locationReceived;
  @override
  final double? distanceKm;
  @override
  final double? deliveryTimeHours;
  @override
  final String contentText;
  final Map<String, dynamic>? _customizations;
  @override
  Map<String, dynamic>? get customizations {
    final value = _customizations;
    if (value == null) return null;
    if (_customizations is EqualUnmodifiableMapView) return _customizations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final List<String>? _attachments;
  @override
  List<String>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isEncrypted;
  @override
  final String? replyToLetterId;
  @override
  @JsonKey()
  final bool deleted;

  @override
  String toString() {
    return 'LetterModel(letterId: $letterId, senderId: $senderId, receiverId: $receiverId, sentDate: $sentDate, receivedDate: $receivedDate, status: $status, locationSentFrom: $locationSentFrom, locationReceived: $locationReceived, distanceKm: $distanceKm, deliveryTimeHours: $deliveryTimeHours, contentText: $contentText, customizations: $customizations, attachments: $attachments, isEncrypted: $isEncrypted, replyToLetterId: $replyToLetterId, deleted: $deleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LetterModelImpl &&
            (identical(other.letterId, letterId) ||
                other.letterId == letterId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.sentDate, sentDate) ||
                other.sentDate == sentDate) &&
            (identical(other.receivedDate, receivedDate) ||
                other.receivedDate == receivedDate) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.locationSentFrom, locationSentFrom) ||
                other.locationSentFrom == locationSentFrom) &&
            (identical(other.locationReceived, locationReceived) ||
                other.locationReceived == locationReceived) &&
            (identical(other.distanceKm, distanceKm) ||
                other.distanceKm == distanceKm) &&
            (identical(other.deliveryTimeHours, deliveryTimeHours) ||
                other.deliveryTimeHours == deliveryTimeHours) &&
            (identical(other.contentText, contentText) ||
                other.contentText == contentText) &&
            const DeepCollectionEquality().equals(
              other._customizations,
              _customizations,
            ) &&
            const DeepCollectionEquality().equals(
              other._attachments,
              _attachments,
            ) &&
            (identical(other.isEncrypted, isEncrypted) ||
                other.isEncrypted == isEncrypted) &&
            (identical(other.replyToLetterId, replyToLetterId) ||
                other.replyToLetterId == replyToLetterId) &&
            (identical(other.deleted, deleted) || other.deleted == deleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    letterId,
    senderId,
    receiverId,
    sentDate,
    receivedDate,
    status,
    locationSentFrom,
    locationReceived,
    distanceKm,
    deliveryTimeHours,
    contentText,
    const DeepCollectionEquality().hash(_customizations),
    const DeepCollectionEquality().hash(_attachments),
    isEncrypted,
    replyToLetterId,
    deleted,
  );

  /// Create a copy of LetterModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LetterModelImplCopyWith<_$LetterModelImpl> get copyWith =>
      __$$LetterModelImplCopyWithImpl<_$LetterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LetterModelImplToJson(this);
  }
}

abstract class _LetterModel implements LetterModel {
  const factory _LetterModel({
    required final String letterId,
    required final String senderId,
    required final String receiverId,
    required final DateTime sentDate,
    final DateTime? receivedDate,
    final String status,
    final String? locationSentFrom,
    final String? locationReceived,
    final double? distanceKm,
    final double? deliveryTimeHours,
    required final String contentText,
    final Map<String, dynamic>? customizations,
    final List<String>? attachments,
    final bool? isEncrypted,
    final String? replyToLetterId,
    final bool deleted,
  }) = _$LetterModelImpl;

  factory _LetterModel.fromJson(Map<String, dynamic> json) =
      _$LetterModelImpl.fromJson;

  @override
  String get letterId;
  @override
  String get senderId;
  @override
  String get receiverId;
  @override
  DateTime get sentDate;
  @override
  DateTime? get receivedDate;
  @override
  String get status; // draft, sent, scheduled, delivered?
  @override
  String? get locationSentFrom;
  @override
  String? get locationReceived;
  @override
  double? get distanceKm;
  @override
  double? get deliveryTimeHours;
  @override
  String get contentText;
  @override
  Map<String, dynamic>? get customizations;
  @override
  List<String>? get attachments;
  @override
  bool? get isEncrypted;
  @override
  String? get replyToLetterId;
  @override
  bool get deleted;

  /// Create a copy of LetterModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LetterModelImplCopyWith<_$LetterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
