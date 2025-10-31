import 'package:freezed_annotation/freezed_annotation.dart';
part 'letter_model.freezed.dart';
part 'letter_model.g.dart';

@freezed
class LetterModel with _$LetterModel {
  const factory LetterModel({
    required String letterId,
    required String senderId,
    required String receiverId,

    required DateTime sentDate,
    DateTime? receivedDate,
    @Default('draft') String status, // draft, sent, scheduled, delivered?

    String? locationSentFrom,
    String? locationReceived,
    double? distanceKm,
    double? deliveryTimeHours,

    required String contentText,
    Map<String, dynamic>? customizations,
    List<String>? attachments,

    bool? isEncrypted,
    String? replyToLetterId,

    @Default(false) bool deleted,
  }) = _LetterModel;

  factory LetterModel.fromJson(Map<String, dynamic> json) => _$LetterModelFromJson(json);
}
