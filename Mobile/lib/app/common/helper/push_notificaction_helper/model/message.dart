import 'dart:convert';

import 'package:dating_app/app/common/helper/push_notificaction_helper/model/notification.dart';

import 'android/android_config.dart';
import 'android/android_fcm_options.dart';
import 'apns/apns.dart';
import 'web_push/web_push.dart';

class CloudMessageModel {
  CloudMessageModel({
    this.name,
    this.data,
    this.notification,
    this.android,
    this.webPush,
    this.apns,
    this.fcmOptions,
    this.token,
    this.topic,
    this.condition,
  });

  final String? name;
  final Map<String, dynamic>? data;
  final MessageNotification? notification;
  final Android? android;
  final WebPush? webPush;
  final Apns? apns;
  final AndroidFcmOptions? fcmOptions;
  final String? token;
  final String? topic;
  final String? condition;

  CloudMessageModel copyWith({
    String? name,
    Map<String, dynamic>? data,
    MessageNotification? notification,
    Android? android,
    WebPush? webPush,
    Apns? apns,
    AndroidFcmOptions? fcmOptions,
    String? token,
    String? topic,
    String? condition,
  }) =>
      CloudMessageModel(
        name: name ?? this.name,
        data: data ?? this.data,
        notification: notification ?? this.notification,
        android: android ?? this.android,
        webPush: webPush ?? this.webPush,
        apns: apns ?? this.apns,
        fcmOptions: fcmOptions ?? this.fcmOptions,
        token: token ?? this.token,
        topic: topic ?? this.topic,
        condition: condition ?? this.condition,
      );

  factory CloudMessageModel.fromRawJson(String str) =>
      CloudMessageModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CloudMessageModel.fromJson(Map<String, dynamic> json) =>
      CloudMessageModel(
        name: json["name"],
        data: jsonDecode(json["data"]),
        notification: MessageNotification.fromJson(json["notification"]),
        android: Android.fromJson(json["android"]),
        webPush: WebPush.fromJson(json["webPush"]),
        apns: Apns.fromJson(json["apns"]),
        fcmOptions: AndroidFcmOptions.fromJson(json["fcm_options"]),
        token: json["token"],
        topic: json["topic"],
        condition: json["condition"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "data": jsonEncode(data),
        "notification": notification?.toJson(),
        "android": android?.toJson(),
        "webPush": webPush?.toJson(),
        "apns": apns?.toJson(),
        "fcm_options": fcmOptions?.toJson(),
        "token": token,
        "topic": topic,
        "condition": condition,
      };
}
