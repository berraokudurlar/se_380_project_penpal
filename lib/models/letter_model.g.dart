// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'letter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LetterModelImpl _$$LetterModelImplFromJson(Map<String, dynamic> json) =>
    _$LetterModelImpl(
      letterId: json['letterId'] as String,
      senderId: json['senderId'] as String,
      receiverId: json['receiverId'] as String,
      sentDate: DateTime.parse(json['sentDate'] as String),
      receivedDate: json['receivedDate'] == null
          ? null
          : DateTime.parse(json['receivedDate'] as String),
      status: json['status'] as String? ?? 'draft',
      estimatedArrivalDate: json['estimatedArrivalDate'] == null
          ? null
          : DateTime.parse(json['estimatedArrivalDate'] as String),
      estimatedArrivalDays: (json['estimatedArrivalDays'] as num?)?.toInt(),
      locationSentFrom: json['locationSentFrom'] as String?,
      locationReceived: json['locationReceived'] as String?,
      contentText: json['contentText'] as String,
      customizations: json['customizations'] as Map<String, dynamic>?,
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isEncrypted: json['isEncrypted'] as bool?,
      replyToLetterId: json['replyToLetterId'] as String?,
      deleted: json['deleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$LetterModelImplToJson(_$LetterModelImpl instance) =>
    <String, dynamic>{
      'letterId': instance.letterId,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'sentDate': instance.sentDate.toIso8601String(),
      'receivedDate': instance.receivedDate?.toIso8601String(),
      'status': instance.status,
      'estimatedArrivalDate': instance.estimatedArrivalDate?.toIso8601String(),
      'estimatedArrivalDays': instance.estimatedArrivalDays,
      'locationSentFrom': instance.locationSentFrom,
      'locationReceived': instance.locationReceived,
      'contentText': instance.contentText,
      'customizations': instance.customizations,
      'attachments': instance.attachments,
      'isEncrypted': instance.isEncrypted,
      'replyToLetterId': instance.replyToLetterId,
      'deleted': instance.deleted,
    };
