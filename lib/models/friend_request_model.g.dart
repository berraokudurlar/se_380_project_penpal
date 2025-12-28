// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FriendRequestModelImpl _$$FriendRequestModelImplFromJson(
  Map<String, dynamic> json,
) => _$FriendRequestModelImpl(
  requestId: json['requestId'] as String,
  fromUserId: json['fromUserId'] as String,
  toUserId: json['toUserId'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  status: json['status'] as String? ?? 'pending',
  respondedAt: json['respondedAt'] == null
      ? null
      : DateTime.parse(json['respondedAt'] as String),
);

Map<String, dynamic> _$$FriendRequestModelImplToJson(
  _$FriendRequestModelImpl instance,
) => <String, dynamic>{
  'requestId': instance.requestId,
  'fromUserId': instance.fromUserId,
  'toUserId': instance.toUserId,
  'createdAt': instance.createdAt.toIso8601String(),
  'status': instance.status,
  'respondedAt': instance.respondedAt?.toIso8601String(),
};
