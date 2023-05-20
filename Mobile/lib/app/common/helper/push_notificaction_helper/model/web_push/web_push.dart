import 'dart:convert';

import 'package:dating_app/app/common/helper/push_notificaction_helper/model/web_push/web_push_fcm_options.dart';

class WebPush {
  WebPush({
    this.headers,
    this.data,
    this.notification,
    this.fcmOptions,
  });

  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? notification;
  final WebPushFcmOptions? fcmOptions;

  WebPush copyWith({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? data,
    Map<String, dynamic>? notification,
    WebPushFcmOptions? fcmOptions,
  }) =>
      WebPush(
        headers: headers ?? this.headers,
        data: data ?? this.data,
        notification: notification ?? this.notification,
        fcmOptions: fcmOptions ?? this.fcmOptions,
      );

  factory WebPush.fromRawJson(String str) => WebPush.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WebPush.fromJson(Map<String, dynamic> json) => WebPush(
        headers: jsonDecode(json["headers"]),
        data: jsonDecode(json["data"]),
        notification: jsonDecode(json["notification"]),
        fcmOptions: WebPushFcmOptions.fromJson(json["fcm_options"]),
      );

  Map<String, dynamic> toJson() => {
        "headers": jsonEncode(headers),
        "data": jsonEncode(data),
        "notification": jsonEncode(notification),
        "fcm_options": fcmOptions?.toJson(),
      };
}
