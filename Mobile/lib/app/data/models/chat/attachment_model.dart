import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/attachment_type.dart';

part 'attachment_model.freezed.dart';
part 'attachment_model.g.dart';

@freezed
class Attachment with _$Attachment {
  @JsonSerializable(explicitToJson: true)
  factory Attachment({
    required String fileName,
    required String url,
    required String fileSize,
    required AttachmentType type,
    Map<String, dynamic>? metadata,
  }) = _Attachment;

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);
}
