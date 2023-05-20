// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'push_notification_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PushNotificationDataRequest _$PushNotificationDataRequestFromJson(
        Map<String, dynamic> json) =>
    PushNotificationDataRequest(
      title: json['title'] as String?,
      body: json['body'] as String?,
      clickAction: json['click_action'] as String?,
      tag: json['tag'] as String?,
      messageModel: json['message_model'] == null
          ? null
          : MessageModel.fromJson(
              json['message_model'] as Map<String, dynamic>),
      messageType: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      channel: json['channel'] == null
          ? null
          : ChannelModel.fromJson(json['channel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PushNotificationDataRequestToJson(
        PushNotificationDataRequest instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'click_action': instance.clickAction,
      'tag': instance.tag,
      'message_model': instance.messageModel?.toJson(),
      'type': _$MessageTypeEnumMap[instance.messageType],
      'channel': instance.channel?.toJson(),
    };

const _$MessageTypeEnumMap = {
  MessageType.normal: 'normal',
  MessageType.pending: 'pending',
  MessageType.system: 'system',
  MessageType.call: 'call',
};
