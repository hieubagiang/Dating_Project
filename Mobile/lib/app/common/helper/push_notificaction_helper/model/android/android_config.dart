import 'dart:convert';

import 'package:dating_app/app/common/helper/push_notificaction_helper/model/android/android_notification.dart';

import '../fcm_options.dart';

class Android {
  Android({
    this.collapseKey,
    this.priority,
    this.ttl,
    this.restrictedPackageName,
    this.data,
    this.notification,
    this.fcmOptions,
    this.directBootOk,
  });

  final String? collapseKey;
  final int? priority;
  final String? ttl;
  final String? restrictedPackageName;
  final Map<String, dynamic>? data;
  final AndroidNotificationModel? notification;
  final FcmOptions? fcmOptions;
  final bool? directBootOk;

  Android copyWith({
    String? collapseKey,
    int? priority,
    String? ttl,
    String? restrictedPackageName,
    Map<String, dynamic>? data,
    AndroidNotificationModel? notification,
    FcmOptions? fcmOptions,
    bool? directBootOk,
  }) =>
      Android(
        collapseKey: collapseKey ?? this.collapseKey,
        priority: priority ?? this.priority,
        ttl: ttl ?? this.ttl,
        restrictedPackageName:
            restrictedPackageName ?? this.restrictedPackageName,
        data: data ?? this.data,
        notification: notification ?? this.notification,
        fcmOptions: fcmOptions ?? this.fcmOptions,
        directBootOk: directBootOk ?? this.directBootOk,
      );

  factory Android.fromRawJson(String str) => Android.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Android.fromJson(Map<String, dynamic> json) => Android(
        collapseKey: json["collapse_key"],
        priority: json["priority"],
        ttl: json["ttl"],
        restrictedPackageName: json["restricted_package_name"],
        data: jsonDecode(json["data"]),
        notification: AndroidNotificationModel.fromJson(json["notification"]),
        fcmOptions: FcmOptions.fromJson(json["fcm_options"]),
        directBootOk: json["direct_boot_ok"],
      );

  Map<String, dynamic> toJson() => {
        "collapse_key": collapseKey,
        "priority": priority,
        "ttl": ttl,
        "restricted_package_name": restrictedPackageName,
        "data": json.encode(data),
        "notification": notification?.toJson(),
        "fcm_options": fcmOptions?.toJson(),
        "direct_boot_ok": directBootOk,
      };
}
