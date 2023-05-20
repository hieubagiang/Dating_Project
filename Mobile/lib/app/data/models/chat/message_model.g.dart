// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => MessageModel(
      senderName: json['sender_name'] as String?,
      senderId: json['sender_id'] as String?,
      messageId: json['message_id'] as String?,
      messageType:
          $enumDecodeNullable(_$MessageTypeEnumMap, json['message_type']),
      text: json['text'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      attachments: json['attachments'] == null
          ? const []
          : customAttachmentFromJson(json['attachments'] as List),
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
      callModel: json['call_model'] == null
          ? null
          : CallModel.fromJson(json['call_model'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MessageModelToJson(MessageModel instance) =>
    <String, dynamic>{
      'message_id': instance.messageId,
      'sender_name': instance.senderName,
      'sender_id': instance.senderId,
      'message_type': _$MessageTypeEnumMap[instance.messageType],
      'text': instance.text,
      'avatar_url': instance.avatarUrl,
      'attachments': instance.attachments?.map((e) => e.toJson()).toList(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': MessageModel.coordinatesToJson(instance.updateAt),
      'call_model': instance.callModel?.toJson(),
    };

const _$MessageTypeEnumMap = {
  MessageType.normal: 'normal',
  MessageType.pending: 'pending',
  MessageType.system: 'system',
  MessageType.call: 'call',
};
