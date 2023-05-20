import 'dart:convert';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/utils/date_time.dart';
import 'package:dating_app/app/data/enums/call_status_enum.dart';
import 'package:dating_app/app/data/enums/call_type.dart';
import 'package:dating_app/app/data/repositories/call_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/entities.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';

import '../../../common/configs/jitsi_config.dart';
import '../../../routes/app_pages.dart';
import '../basic_user/basic_user.dart';

part 'call_model.freezed.dart';
part 'call_model.g.dart';

@freezed
class CallModel with _$CallModel {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory CallModel({
    String? callId,
    String? channelId,
    String? callerId,
    String? messageId,
    BasicUserModel? caller,
    String? receiverId,
    BasicUserModel? receiver,
    CallStatusType? callStatus,
    CallType? callType,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createAt,
    DateTime? updateAt,
  }) = _CallModel;

  const CallModel._();

  factory CallModel.fromJson(Map<String, dynamic> json) =>
      _$CallModelFromJson(json);

  Future<void> showIncomingCall() async {
    CallKitParams callKitParams = CallKitParams(
      id: callId ?? '',
      nameCaller: caller?.name ?? '',
      appName: 'Dating',
      avatar: caller?.avatar ?? '',
      type: 0,
      textAccept: 'Accept',
      textDecline: 'Decline',
      textMissedCall: 'Missed call',
      textCallback: 'Call back',
      duration: 30000,
      extra: <String, dynamic>{'call_model': jsonEncode(toJson())},
      android: AndroidParams(
        isCustomNotification: true,
        isShowLogo: true,
        isShowCallback: true,
        isShowMissedCallNotification: true,
        ringtonePath: 'system_ringtone_default',
        backgroundColor: '#0955fa',
        backgroundUrl: caller?.avatar,
        actionColor: '#4CAF50',
        incomingCallNotificationChannelName: "Incoming Call",
        missedCallNotificationChannelName: "Missed Call",
      ),
    );
    final res = await FlutterCallkitIncoming.showCallkitIncoming(callKitParams);
    return res;
  }

  Future<void> startACall() async {
    CallKitParams params = CallKitParams(
      id: callId,
      appName: 'Dating',
      nameCaller: caller?.name ?? '',
      type: 1,
      extra: <String, dynamic>{'call_model': jsonEncode(toJson())},
    );
    //await FlutterCallkitIncoming.endAllCalls();
    await FlutterCallkitIncoming.startCall(params);
    final res = await FlutterCallkitIncoming.activeCalls();
    print(res);
  }

  Future<void> endACall() async {
    await FlutterCallkitIncoming.endCall(callId ?? '');
  }

  Future<void> endAllCalls() async {
    await FlutterCallkitIncoming.endAllCalls();
  }

  // call back missed call
  CallModel createCallBackCall() {
    return CallModel(
      callId: callId,
      callerId: receiverId,
      caller: receiver,
      receiverId: callerId,
      receiver: caller,
      callStatus: CallStatusType.started,
      createAt: DateTime.now(),
      updateAt: DateTime.now(),
    );
  }

  Future<void> startJitsiCall(bool isCaller) async {
    BasicUserModel user = isCaller ? caller! : receiver!;
    String channelId = callId ?? '';
    String currentName = user.name;
    String avatarUrl = user.avatar;
    var route = Get.currentRoute;

    if (route == RouteList.call) {
      Get.back();
    }
    var options = JitsiConfig.createMeetingOptions(
      channelId,
      currentName,
      avatarUrl,
      callType ?? CallType.voice,
    );
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onConferenceWillJoin: (url) => print("onConferenceWillJoin: url: $url"),
        onConferenceJoined: (url) => print("onConferenceJoined: url: $url"),
        onConferenceTerminated: (url, error) =>
            print("onConferenceTerminated: url: $url, error: $error"),
        onParticipantLeft: (participant) async {
          print("onParticipantLeft: participant: $participant");
          await JitsiMeetWrapper.hangUp();
          // set status on firebase
          FlutterCallkitIncoming.endAllCalls();
        },
        onClosed: () async {
          print("onClosed");
          FlutterCallkitIncoming.endAllCalls();
          Get.find<CallRepository>().stopRinging(
              callModel: copyWith(
            callStatus: CallStatusType.ended,
            endTime: DateTime.now(),
          ));
        },
      ),
    );
  }

  String? getCallTitle({required bool isCaller}) =>
      callStatus?.getCallTitle(isCaller, callType ?? CallType.video);

  String? getCallMessage({required bool isCaller}) =>
      callStatus?.getCallMessage(
          isCaller: isCaller,
          callType: callType ?? CallType.video,
          time: getDuration());

  String getDuration() => callStatus == CallStatusType.ended
      ? DateTimeUtils.calculateCallDuration(startTime!, endTime!)
      : DateTimeUtils.getStringDate(createAt ?? DateTime.now(),
              pattern: Pattern.hhmm) ??
          '';

  Widget getCallIcon({required bool isCaller}) =>
      callStatus?.getCallWidget(
          isCaller: isCaller, callType: callType ?? CallType.video) ??
      Container();
}
