import 'dart:convert';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/models/call/call_model.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/notification_type.dart';
import '../payment/payment_model.dart';

part 'notification_payload.freezed.dart';
part 'notification_payload.g.dart';

@Freezed()
class NotificationPayload with _$NotificationPayload {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory NotificationPayload({
    NotificationType? notificationType,
    CallModel? callModel,
    PaymentModel? paymentModel,
    ChannelModel? channelModel,
    @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK') String? clickAction,
  }) = _NotificationPayload;

  const NotificationPayload._();

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadFromJson(json);

  factory NotificationPayload.fromPayload(Map<String, dynamic> json) =>
      NotificationPayload.fromJson({
        "notification_type": json['notification_type'] == null
            ? null
            : json["notification_type"],
        "call_model": json["call_model"] == null
            ? null
            : jsonDecode(json["call_model"]) as Map<String, dynamic>?,
        "channel_model": json["channel_model"] == null
            ? null
            : jsonDecode(json["channel_model"]) as Map<String, dynamic>?,
      });

  void checkRoute() {
    if (notificationType == NotificationType.match) {
      if (channelModel != null && channelModel?.channelId != null) {
        Get.toNamed(
          RouteList.chatDetailRoute(id: channelModel?.channelId ?? ''),
        );
      }
    }
  }
}
