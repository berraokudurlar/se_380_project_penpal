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
    @Default('draft') String status, //  sent, delivered?

    DateTime? estimatedArrivalDate,
    int? estimatedArrivalDays,


    String? locationSentFrom,
    String? locationReceived,



    required String contentText,
    Map<String, dynamic>? customizations,
    List<String>? attachments,

    bool? isEncrypted,
    String? replyToLetterId,

    @Default(false) bool deleted,
  }) = _LetterModel;

  factory LetterModel.fromJson(Map<String, dynamic> json) => _$LetterModelFromJson(json);
}
