// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Data _$$_DataFromJson(Map<String, dynamic> json) => _$_Data(
      clickAction:
          json['click_action'] as String? ?? 'FLUTTER_NOTIFICATION_CLICK',
      alert: json['alert'] as bool? ?? true,
      contentAvailable: json['content_available'] as bool? ?? true,
    );

Map<String, dynamic> _$$_DataToJson(_$_Data instance) => <String, dynamic>{
      'click_action': instance.clickAction,
      'alert': instance.alert,
      'content_available': instance.contentAvailable,
    };

_$_SendNotificationRequest _$$_SendNotificationRequestFromJson(
        Map<String, dynamic> json) =>
    _$_SendNotificationRequest(
      userIds: (json['user_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      data: json['data'] as Map<String, dynamic>?,
      notification: json['notification'] == null
          ? null
          : NotificationRequest.fromJson(
              json['notification'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SendNotificationRequestToJson(
        _$_SendNotificationRequest instance) =>
    <String, dynamic>{
      'user_ids': instance.userIds,
      'data': instance.data,
      'notification': instance.notification,
    };
