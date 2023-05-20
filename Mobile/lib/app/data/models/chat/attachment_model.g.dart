// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Attachment _$$_AttachmentFromJson(Map<String, dynamic> json) =>
    _$_Attachment(
      fileName: json['fileName'] as String,
      url: json['url'] as String,
      fileSize: json['fileSize'] as String,
      type: $enumDecode(_$AttachmentTypeEnumMap, json['type']),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_AttachmentToJson(_$_Attachment instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'url': instance.url,
      'fileSize': instance.fileSize,
      'type': _$AttachmentTypeEnumMap[instance.type]!,
      'metadata': instance.metadata,
    };

const _$AttachmentTypeEnumMap = {
  AttachmentType.image: 'image',
  AttachmentType.video: 'video',
  AttachmentType.file: 'file',
};
