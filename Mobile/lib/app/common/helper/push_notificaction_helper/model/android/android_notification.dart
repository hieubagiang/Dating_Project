// To parse this JSON data, do
//
//     final androidNotificationModel = androidNotificationModelFromJson(jsonString);

import 'dart:convert';

class AndroidNotificationModel {
  AndroidNotificationModel({
    this.title,
    this.body,
    this.icon,
    this.color,
    this.sound,
    this.tag,
    this.clickAction,
    this.bodyLocKey,
    this.bodyLocArgs,
    this.titleLocKey,
    this.titleLocArgs,
    this.channelId,
    this.ticker,
    this.sticky,
    this.eventTime,
    this.localOnly,
    this.notificationPriority,
    this.defaultSound,
    this.defaultVibrateTimings,
    this.defaultLightSettings,
    this.vibrateTimings,
    this.visibility,
    this.notificationCount,
    this.image,
  });

  final String? title;
  final String? body;
  final String? icon;
  final String? color;
  final String? sound;
  final String? tag;
  final String? clickAction;
  final String? bodyLocKey;
  final List<String>? bodyLocArgs;
  final String? titleLocKey;
  final List<String>? titleLocArgs;
  final String? channelId;
  final String? ticker;
  final bool? sticky;
  final String? eventTime;
  final bool? localOnly;
  final int? notificationPriority;
  final bool? defaultSound;
  final bool? defaultVibrateTimings;
  final bool? defaultLightSettings;
  final List<String>? vibrateTimings;
  final int? visibility;
  final int? notificationCount;
  final String? image;

  AndroidNotificationModel copyWith({
    String? title,
    String? body,
    String? icon,
    String? color,
    String? sound,
    String? tag,
    String? clickAction,
    String? bodyLocKey,
    List<String>? bodyLocArgs,
    String? titleLocKey,
    List<String>? titleLocArgs,
    String? channelId,
    String? ticker,
    bool? sticky,
    String? eventTime,
    bool? localOnly,
    int? notificationPriority,
    bool? defaultSound,
    bool? defaultVibrateTimings,
    bool? defaultLightSettings,
    List<String>? vibrateTimings,
    int? visibility,
    int? notificationCount,
    String? image,
  }) =>
      AndroidNotificationModel(
        title: title ?? this.title,
        body: body ?? this.body,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        sound: sound ?? this.sound,
        tag: tag ?? this.tag,
        clickAction: clickAction ?? this.clickAction,
        bodyLocKey: bodyLocKey ?? this.bodyLocKey,
        bodyLocArgs: bodyLocArgs ?? this.bodyLocArgs,
        titleLocKey: titleLocKey ?? this.titleLocKey,
        titleLocArgs: titleLocArgs ?? this.titleLocArgs,
        channelId: channelId ?? this.channelId,
        ticker: ticker ?? this.ticker,
        sticky: sticky ?? this.sticky,
        eventTime: eventTime ?? this.eventTime,
        localOnly: localOnly ?? this.localOnly,
        notificationPriority: notificationPriority ?? this.notificationPriority,
        defaultSound: defaultSound ?? this.defaultSound,
        defaultVibrateTimings:
            defaultVibrateTimings ?? this.defaultVibrateTimings,
        defaultLightSettings: defaultLightSettings ?? this.defaultLightSettings,
        vibrateTimings: vibrateTimings ?? this.vibrateTimings,
        visibility: visibility ?? this.visibility,
        notificationCount: notificationCount ?? this.notificationCount,
        image: image ?? this.image,
      );

  factory AndroidNotificationModel.fromRawJson(String str) =>
      AndroidNotificationModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AndroidNotificationModel.fromJson(Map<String, dynamic> json) =>
      AndroidNotificationModel(
        title: json["title"],
        body: json["body"],
        icon: json["icons"],
        color: json["color"],
        sound: json["sound"],
        tag: json["tag"],
        clickAction: json["click_action"],
        bodyLocKey: json["body_loc_key"],
        bodyLocArgs: List<String>.from(json["body_loc_args"].map((x) => x)),
        titleLocKey: json["title_loc_key"],
        titleLocArgs: List<String>.from(json["title_loc_args"].map((x) => x)),
        channelId: json["channel_id"],
        ticker: json["ticker"],
        sticky: json["sticky"],
        eventTime: json["event_time"],
        localOnly: json["local_only"],
        notificationPriority: json["notification_priority"],
        defaultSound: json["default_sound"],
        defaultVibrateTimings: json["default_vibrate_timings"],
        defaultLightSettings: json["default_light_settings"],
        vibrateTimings:
            List<String>.from(json["vibrate_timings"].map((x) => x)),
        visibility: json["visibility"],
        notificationCount: json["notification_count"],
        image: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "icons": icon,
        "color": color,
        "sound": sound,
        "tag": tag,
        "click_action": clickAction,
        "body_loc_key": bodyLocKey,
        "body_loc_args": List<dynamic>.from(bodyLocArgs?.map((x) => x) ?? []),
        "title_loc_key": titleLocKey,
        "title_loc_args": List<dynamic>.from(titleLocArgs?.map((x) => x) ?? []),
        "channel_id": channelId,
        "ticker": ticker,
        "sticky": sticky,
        "event_time": eventTime,
        "local_only": localOnly,
        "notification_priority": notificationPriority,
        "default_sound": defaultSound,
        "default_vibrate_timings": defaultVibrateTimings,
        "default_light_settings": defaultLightSettings,
        "vibrate_timings":
            List<dynamic>.from(vibrateTimings?.map((x) => x) ?? []),
        "visibility": visibility,
        "notification_count": notificationCount,
        "images": image,
      };
}
