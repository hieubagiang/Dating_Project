// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_NotificationPayload _$$_NotificationPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_NotificationPayload(
      notificationType: $enumDecodeNullable(
          _$NotificationTypeEnumMap, json['notification_type']),
      callModel: json['call_model'] == null
          ? null
          : CallModel.fromJson(json['call_model'] as Map<String, dynamic>),
      paymentModel: json['payment_model'] == null
          ? null
          : PaymentModel.fromJson(
              json['payment_model'] as Map<String, dynamic>),
      channelModel: json['channel_model'] == null
          ? null
          : ChannelModel.fromJson(
              json['channel_model'] as Map<String, dynamic>),
      clickAction:
          json['click_action'] as String? ?? 'FLUTTER_NOTIFICATION_CLICK',
    );

Map<String, dynamic> _$$_NotificationPayloadToJson(
        _$_NotificationPayload instance) =>
    <String, dynamic>{
      'notification_type': _$NotificationTypeEnumMap[instance.notificationType],
      'call_model': instance.callModel,
      'payment_model': instance.paymentModel,
      'channel_model': instance.channelModel,
      'click_action': instance.clickAction,
    };

const _$NotificationTypeEnumMap = {
  NotificationType.newMessage: 'newMessage',
  NotificationType.match: 'match',
  NotificationType.newLike: 'newLike',
  NotificationType.newSuperLike: 'newSuperLike',
  NotificationType.call: 'call',
  NotificationType.payment: 'payment',
  NotificationType.other: 'other',
};
