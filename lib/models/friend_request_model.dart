import 'package:freezed_annotation/freezed_annotation.dart';
part 'friend_request_model.freezed.dart';
part 'friend_request_model.g.dart';

@freezed
class FriendRequestModel with _$FriendRequestModel {
  const factory FriendRequestModel({
    required String requestId,
    required String fromUserId,
    required String toUserId,
    required DateTime createdAt,
    @Default('pending') String status, // 'pending', 'accepted', 'rejected'
    DateTime? respondedAt,
  }) = _FriendRequestModel;

  factory FriendRequestModel.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestModelFromJson(json);
}