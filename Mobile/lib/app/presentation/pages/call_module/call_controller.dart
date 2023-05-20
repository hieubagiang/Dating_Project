import 'dart:async';
import 'dart:convert';

import 'package:dating_app/app/common/helper/push_notificaction_helper/push_notification_helper.dart';
import 'package:dating_app/app/data/enums/call_status_enum.dart';
import 'package:dating_app/app/data/models/call/call_model.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:dating_app/app/data/repositories/message_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

import '../../../common/base/base_controller.dart';
import '../../../data/enums/notification_type.dart';
import '../../../data/models/notification/notification_payload.dart';
import '../../../data/repositories/call_repository.dart';

class CallController extends BaseController {
  final data = ''.obs;
  Rx<CallModel?> callModel = Rx(null);
  final CallRepository _callRepository = Get.find<CallRepository>();
  final PushNotificationHelper _pushHelper = PushNotificationHelper();
  final ChatRepository _chatRepository = Get.find<ChatRepositoryImpl>();
  Timer? ringTimer;

  @override
  Future<void> onInit() async {
    super.onInit();
    // await FlutterCallkitIncoming.endAllCalls();
    var currentCall = await getCurrentCall();
    JitsiMeetWrapper;

    _pushHelper.onMessageStream.listen((RemoteMessage message) async {
      final res = NotificationPayload.fromPayload(message.data);
      if (res.notificationType != NotificationType.call ||
          res.callModel == null) {
        return;
      }
      final callModel = res.callModel;
      this.callModel.value = callModel;
      switch (callModel!.callStatus) {
        case CallStatusType.ringing:
          await res.callModel?.showIncomingCall();
          break;
        case CallStatusType.accepted:
          ringTimer?.cancel();
          if (callModel.callStatus == CallStatusType.accepted) {
            callModel.startJitsiCall(isCaller(callModel));
          }
          _callRepository.changeCall(
              callModel: callModel.copyWith(
                  callStatus: CallStatusType.started,
                  startTime: DateTime.now()));
          break;
        case CallStatusType.rejected:
          await FlutterCallkitIncoming.endCall(callModel.callId ?? '');
          if (Get.currentRoute == RouteList.call) {
            Get.back();
          }
          break;
        case CallStatusType.unanswered:
          await FlutterCallkitIncoming.endCall(callModel.callId ?? '');
          break;
        case CallStatusType.ended:
          await JitsiMeetWrapper.hangUp();
          break;
        default:
          break;
      }
    });
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
      CallModel? callModel;
      if (event?.body['extra'].isEmpty) {
        print('null ');
      } else {
        callModel =
            CallModel.fromJson(jsonDecode(event?.body['extra']['call_model']));
      }
      this.callModel.value = callModel;
      switch (event!.event) {
        case Event.ACTION_CALL_INCOMING:
          print('ACTION_CALL_INCOMING');
          break;
        case Event.ACTION_CALL_START:
          // started an outgoing call
          // show screen calling in Flutter
          Get.toNamed(RouteList.call,
              arguments: CallModel.fromJson(event.body['extra']['call_model']));
          break;
        case Event.ACTION_CALL_ACCEPT:
          print('ACTION_CALL_ACCEPT');
          // change status call to accepted
          await _callRepository.changeCall(
              callModel: callModel!.copyWith(
                  callStatus: CallStatusType.accepted,
                  startTime: DateTime.now()));
          callModel.startJitsiCall(isCaller(callModel));

          break;
        case Event.ACTION_CALL_DECLINE:
          _callRepository.changeCall(
              callModel:
                  callModel!.copyWith(callStatus: CallStatusType.rejected));
          break;
        case Event.ACTION_CALL_ENDED:
          print('ACTION_CALL_ENDED');
          print('callModel?.callStatus ${callModel}');

          break;
        case Event.ACTION_CALL_TIMEOUT:
          // TODO: missed an incoming call
          break;
        case Event.ACTION_CALL_CALLBACK:
          final callBackModel = callModel?.createCallBackCall();
          ringCallee(callBackModel!);
          break;
        case Event.ACTION_DID_UPDATE_DEVICE_PUSH_TOKEN_VOIP:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_HOLD:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_MUTE:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_DMTF:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_GROUP:
          // TODO: Handle this case.
          break;
        case Event.ACTION_CALL_TOGGLE_AUDIO_SESSION:
          // TODO: Handle this case.
          break;
      }
    });
  }

  bool isCaller(CallModel callModel) =>
      Get.find<MainController>().currentUser.value?.id == callModel.callerId;

  @override
  Future<void> onReady() async {
    super.onReady();
  }

  Future<void> ringCallee(CallModel callModel) async {
    await _callRepository.ringPhone(callModel: callModel);
    _chatRepository.sendMessage(
        channelId: callModel.channelId ?? '',
        message: MessageModel.fromCallMessage(callModel));

    this.callModel.value = callModel;
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/sounds/waiting_call_sound.wav',
      looping: true, // Android only - API >= 28
      volume: 0.5, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );

    Get.toNamed(
      RouteList.call,
    );
    ringTimer = Timer(Duration(seconds: 30), () {
      if (this.callModel.value?.callStatus == CallStatusType.ringing) {
        stopRinging(isCancelled: false);
      }
    });
  }

  Future<void> stopRinging({required bool isCancelled}) async {
    if (callModel.value == null) return;
    CallModel stopCallModel = callModel.value!.copyWith(
      callStatus: CallStatusType.unanswered,
    );
    _callRepository.stopRinging(callModel: stopCallModel);
    FlutterRingtonePlayer.stop();
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/sounds/end-call.mp3',
      looping: true, // Android only - API >= 28
      volume: 0.3, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
    await Future.delayed(Duration(milliseconds: 200));
    FlutterRingtonePlayer.stop();

    if (Get.currentRoute == RouteList.call) {
      Get.back();
    }
    callModel.value = null;
  }

  getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    if (calls is List) {
      if (calls.isNotEmpty) {
        print('DATA: $calls');
        return calls[0];
      } else {
        return null;
      }
    }
  }
}
