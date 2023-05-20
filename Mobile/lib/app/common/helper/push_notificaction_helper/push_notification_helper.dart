import 'dart:convert';

import 'package:dating_app/app/common/utils/functions.dart';
import 'package:dating_app/app/data/models/call/call_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

import '../../../data/enums/call_status_enum.dart';
import '../../../data/enums/notification_type.dart';
import '../../../data/models/notification/notification_payload.dart';

class PushNotificationHelper {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Function(RemoteMessage)? handleNotificationTap;
  String? pushToken;
  Function(String)? onGotToken;
  String? _payLoad;
  Function(RemoteMessage)? onMessage;

  Stream<RemoteMessage> get onMessageStream =>
      FirebaseMessaging.onMessage.asBroadcastStream();
  static final PushNotificationHelper _singleton =
      PushNotificationHelper._internal();
  DateTime? lastSenTime;

  factory PushNotificationHelper() {
    return _singleton;
  }

  PushNotificationHelper._internal();

  Future initialize({Function(RemoteMessage)? handleNotificationTap}) async {
    await Firebase.initializeApp();
    this.handleNotificationTap = handleNotificationTap;
    await _fcmInitialization();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future _fcmInitialization() async {
    try {
      pushToken = await getPushToken();
      FirebaseMessaging.instance.onTokenRefresh.listen((token) {
        FunctionUtils.logWhenDebug(
            this, 'onTokenRefresh, register new FCM token');
        pushToken = token;
      });

      RemoteMessage? initMessage = await _firebaseMessaging.getInitialMessage();
      if (initMessage != null) {
        _payLoad = jsonEncode(initMessage);
        handleNotificationTap?.call(initMessage);
      }

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        if (lastSenTime != message.sentTime) {
          lastSenTime = message.sentTime;
          onMessage?.call(message);
          _payLoad = getNotificationContent(message);
          FunctionUtils.logWhenDebug(this, 'onMessage: message.data $_payLoad');
        }
      });
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        handleNotificationTap?.call(message);
      });
    } catch (e) {
      FunctionUtils.logWhenDebug(this, e.toString());
    }
  }

  Future<String?> getPushToken() async {
    pushToken ??= await _firebaseMessaging.getToken();
    FunctionUtils.logWhenDebug(this, 'fcm token: $pushToken');
    return pushToken;
  }

  Future<void> unSubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  Future<void> subscribeToTopic(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> deleteToken() async {
    pushToken = null;
    await _firebaseMessaging.deleteToken();
  }
}

String getNotificationContent(RemoteMessage? message) {
  if (message == null) return 'RemoteMessage is Null';
  final body = {
    'notification': {
      'title': message.notification?.title,
      'body': message.notification?.body,
    },
    'data': message.data,
    "collapse_key": message.collapseKey,
    "message_id": message.messageId,
    "sent_time": message.sentTime?.millisecondsSinceEpoch,
    "from": message.from,
    "ttl": message.ttl,
  };
  return jsonEncode(body);
}

Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage remoteMessage) async {
  final res = NotificationPayload.fromPayload(remoteMessage.data);
  if (res.notificationType == NotificationType.call &&
      res.callModel?.callStatus == CallStatusType.ringing) {
    await res.callModel?.showIncomingCall();
  }

  FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
    switch (event!.event) {
      case Event.ACTION_CALL_INCOMING:
        print('ACTION_CALL_INCOMING');
        break;
      case Event.ACTION_CALL_START:
      case Event.ACTION_CALL_ACCEPT:
        CallModel callModel =
            CallModel.fromJson(event.body['extra']['call_model']);
        callModel.startACall();
        break;
      case Event.ACTION_CALL_DECLINE:
        // TODO: declined an incoming call
        break;
      case Event.ACTION_CALL_ENDED:
        // TODO: ended an incoming/outgoing call
        break;
      case Event.ACTION_CALL_TIMEOUT:
        // TODO: missed an incoming call
        break;
      case Event.ACTION_CALL_CALLBACK:
        // TODO: only Android - click action `Call back` from missed call notification
        break;
      case Event.ACTION_CALL_TOGGLE_HOLD:
        // TODO: only iOS
        break;
      case Event.ACTION_CALL_TOGGLE_MUTE:
        // TODO: only iOS
        break;
      case Event.ACTION_CALL_TOGGLE_DMTF:
        // TODO: only iOS
        break;
      case Event.ACTION_CALL_TOGGLE_GROUP:
        // TODO: only iOS
        break;
      case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
        // TODO: only iOS
        break;
      case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
        // TODO: only iOS
        break;
    }
  });
}
