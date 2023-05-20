import 'package:flutter_local_notifications/flutter_local_notifications.dart';

///Config Channel
///
const defaultNotificationChannel = "Chung";
const defaultNotificationChannelId = "dating_app_default_channel";
const defaultNotificationChannelDescription =
    "Channel for default notification";
const notificationIconPath = '@mipmap/ic_launcher';
const defaultNotificationSoundPath = 'normal';

const staticsNotificationChannel = "Thốn  g kê dữ liệu";
const staticsNotificationChannelId = "dating_app_statics_channel";
const staticsNotificationChannelDescription =
    "Channel for statics notification";
const staticsNotificationSoundPath = '';

const alertNotificationChannel = "Cảnh báo";
const alertNotificationChannelId = "dating_app_alert_channel";
const alertNotificationChannelDescription = "Channel for alert notification";
const alertNotificationSoundPath = 'red_alert';

enum NotificationType { silent, normal, alert }

class NotificationTypeEnum {
  static NotificationType? getNotificationType(String inputValue) {
    return NotificationType.values
        .where((value) => value.label == inputValue)
        .first;
  }

  static NotificationType getNotificationTypeFromMessage(double value) {
    return NotificationType.normal;
  }
}

extension NotificationTypeExtension on NotificationType {
  double get id {
    switch (this) {
      case NotificationType.silent:
        return 1;
      case NotificationType.normal:
        return 2;
      case NotificationType.alert:
        return 3;
      default:
        return -1;
    }
  }

  String get label {
    switch (this) {
      case NotificationType.silent:
        return 'STATICS';
      case NotificationType.normal:
        return 'NORMAL';
      case NotificationType.alert:
        return 'ALERT';
      default:
        return '';
    }
  }

  String? get soundPath {
    switch (this) {
      case NotificationType.normal:
        return defaultNotificationSoundPath;
      case NotificationType.alert:
        return alertNotificationSoundPath;
      case NotificationType.silent:
        return staticsNotificationSoundPath;
    }
  }

  String get notificationId {
    switch (this) {
      case NotificationType.normal:
        return defaultNotificationChannelId;
      case NotificationType.alert:
        return alertNotificationChannelId;
      case NotificationType.silent:
        return staticsNotificationChannelId;
    }
  }

  String get notificationChannel {
    switch (this) {
      case NotificationType.normal:
        return defaultNotificationChannel;
      case NotificationType.alert:
        return alertNotificationChannel;
      case NotificationType.silent:
        return staticsNotificationChannel;
    }
  }

  String get notificationChannelDescription {
    switch (this) {
      case NotificationType.normal:
        return defaultNotificationChannelDescription;
      case NotificationType.alert:
        return alertNotificationChannelDescription;
      case NotificationType.silent:
        return staticsNotificationChannelDescription;
    }
  }

  Importance get importance {
    switch (this) {
      case NotificationType.normal:
        return Importance.high;
      case NotificationType.alert:
        return Importance.max;
      case NotificationType.silent:
        return Importance.low;
    }
  }
}
