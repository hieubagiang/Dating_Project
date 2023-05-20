import 'dart:async';
import 'dart:typed_data';

import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const highImportance = "High Importance channel";
const highChannelId = "highChannelId";
const highChannelDescription = "Floating notification with sound";
const notificationSoundPath = 'new_message.mp3';
const notificationIconPath = 'ic_stat';

class LocalNotificationHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static final LocalNotificationHelper _localNotificationHelper =
      LocalNotificationHelper._internal();
  static int _notificationId = 1;

  factory LocalNotificationHelper() {
    return _localNotificationHelper;
  }

  // create stream to listen notification
  final StreamController<String> didReceiveLocalNotificationSubject =
      StreamController<String>.broadcast();
  Function(String)? onTapLocalNotification;

  LocalNotificationHelper._internal();

  Future<void> init() async {
    var initializationSettings = await _getPlatformSettings();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
      onDidReceiveBackgroundNotificationResponse:
          onDidReceiveBackgroundNotificationResponse,
    );

    _createNotificationChannel(
      id: highChannelId,
      channelName: highImportance,
      description: highChannelDescription,
      soundPath: notificationSoundPath,
      importance: Importance.max,
    );
  }

  void _createNotificationChannel(
      {required String id,
      required String channelName,
      required String description,
      String? soundPath,
      Int64List? vibrationPattern,
      Importance? importance}) async {
    var androidNotificationChannel = AndroidNotificationChannel(
      id,
      channelName,
      description: description,
      playSound: soundPath?.isNotEmpty ?? false,
      sound: soundPath != null
          ? RawResourceAndroidNotificationSound(soundPath.split('.').first)
          : null,
      enableLights: soundPath?.isNotEmpty ?? false,
      vibrationPattern: vibrationPattern,
      importance: importance ?? Importance.max,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);
  }

  Future<InitializationSettings> _getPlatformSettings() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings(notificationIconPath);

    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            // uncomment if want to support ios <10.
            // onDidReceiveLocalNotification: onDidReceiveLocalNotification,
            );

    return const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
  }

  Future<void> showNotification(
      {required String title,
      required String body,
      String channelId = highChannelId,
      String channelName = highImportance,
      String channelDescription = highChannelDescription,
      String channelSound = notificationSoundPath,
      String? payload,
      Importance? importance,
      Priority? priority,
      Int64List? vibrationPatternCustom}) async {
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 200;
    vibrationPattern[2] = 200;
    vibrationPattern[3] = 200;

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      largeIcon: const DrawableResourceAndroidBitmap(
        notificationIconPath,
      ),
      icon: notificationIconPath,
      color: ColorUtils.primaryColor,
      importance: importance ?? Importance.max,
      priority: Priority.max,
      category: AndroidNotificationCategory.social,
      vibrationPattern: vibrationPatternCustom ?? vibrationPattern,
      sound: RawResourceAndroidNotificationSound(
        notificationSoundPath.split('.').first,
      ),
    );
    DarwinNotificationDetails iOSPlatformChannelSpecifics = DarwinNotificationDetails(
        presentAlert: true,
        // Present an alert when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentBadge: true,
        // Present the badge number when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        presentSound: true,
        // Play a sound when the notification is displayed and the application is in the foreground (only from iOS 10 onwards)
        sound: channelSound,
        // Specifics the file pat  h to play (only from iOS 10 onwards)
        badgeNumber: 1,

        // The application's icon badge number
        //attachments: List<IOSNotificationAttachment>?, (only from iOS 10 onwards)
        //subtitle: String?, //Secondary description  (only from iOS 10 onwards)
        threadIdentifier: _notificationId.toString());
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    _notificationId++;
    await flutterLocalNotificationsPlugin.show(
      _notificationId,
      title,
      body,
      platformChannelSpecifics,
      payload: payload,
    );
  }

  void onDidReceiveNotificationResponse(NotificationResponse details) {
    // didReceiveLocalNotificationSubject.add(details.payload!);
    onTapLocalNotification?.call(details.payload!);
  }
}

@pragma('vm:entry-point')
void onDidReceiveBackgroundNotificationResponse(
    NotificationResponse notificationResponse) {
  // ignore: avoid_print
  print('notification(${notificationResponse.id}) action tapped: '
      '${notificationResponse.actionId} with'
      ' payload: ${notificationResponse.payload}');
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}
