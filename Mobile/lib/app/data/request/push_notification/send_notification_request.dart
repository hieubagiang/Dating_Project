import 'package:dating_app/app/data/request/push_notification/notification_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'push_notification_data_request.dart';

part 'send_notification_request.freezed.dart';
part 'send_notification_request.g.dart';

@freezed
class Data with _$Data {
  const factory Data({
    @JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
        String? clickAction,
    @JsonKey(defaultValue: true) bool? alert,
    @JsonKey(name: "content_available", defaultValue: true)
        bool? contentAvailable,
  }) = _Data;

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
}

@freezed
class SendNotificationRequest with _$SendNotificationRequest {
  const factory SendNotificationRequest({
    @JsonKey(name: "user_ids") List<String>? userIds,
    Map<String, dynamic>? data,
    NotificationRequest? notification,
  }) = _SendNotificationRequest;

  factory SendNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$SendNotificationRequestFromJson(json);
}
