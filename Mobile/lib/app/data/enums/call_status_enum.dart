import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/call_type.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CallStatusType { ringing, accepted, started, ended, rejected, unanswered }

class CallStatusTypeEnum {
  static List<CallStatusType> get list {
    return CallStatusType.values.toList();
  }

  static CallStatusType? getType(String? constantValue) {
    if (constantValue == null) {
      return null;
    }
    return CallStatusType.values
        .where((value) => value.constantValue == constantValue)
        .first;
  }
}

extension CallStatusTypeEnumExtension on CallStatusType {
  String get constantValue {
    switch (this) {
      case CallStatusType.ringing:
        return 'ringing';
      case CallStatusType.accepted:
        return 'accepted';
      case CallStatusType.started:
        return 'calling';
      case CallStatusType.ended:
        return 'ended';
      case CallStatusType.rejected:
        return 'rejected';
      case CallStatusType.unanswered:
        return 'unanswered';
    }
  }

  // I need function return message when call status is ended, rejected, unanswered
  String getCallTitle(bool isCaller, CallType callType) {
    switch (this) {
      case CallStatusType.ringing:
        return isCaller
            ? 'outgoing_call_title'.trParams({
                'callType': callType.name.tr,
              })
            : 'incoming_call_title'.trParams({
                'callType': callType.name.tr,
              });
      case CallStatusType.started:
        return 'call_started_title'.trParams({
          'callType': callType.name.tr,
        });
      case CallStatusType.ended:
        return 'call_ended_title'.trParams({
          'callType': callType.name.tr,
        });
      case CallStatusType.rejected:
        return 'call_rejected_title'.trParams({
          'callType': callType.name.tr,
        });
      case CallStatusType.unanswered:
        return 'call_unanswered_title'.trParams({
          'callType': callType.name.tr,
        });
      default:
        return "";
    }
  }

// I need function return message when call status is ended, rejected, unanswered
  String getCallMessage(
      {required bool isCaller, required CallType callType, String? time}) {
    switch (this) {
      case CallStatusType.ringing:
        return isCaller
            ? 'outgoing_call_message'.trParams({
                'callType': callType.name.tr,
              })
            : 'incoming_call_message'.trParams({
                'callType': callType.name.tr,
              });
      case CallStatusType.accepted:
        return '';
      case CallStatusType.started:
        return 'call_started_message'.trParams({
          'callType': callType.name.tr,
        });
      case CallStatusType.ended:
        return 'call_ended_message'.trParams({
          'duration': time ?? '',
        });
      case CallStatusType.rejected:
        return 'call_rejected_message'.trParams({
          'time': time ?? '',
        });
      case CallStatusType.unanswered:
        return 'call_unanswered_message'.trParams({
          'time': time ?? '',
        });
    }
  }

  Widget getCallWidget({required bool isCaller, required CallType callType}) {
    return Container(
      width: 36.h,
      height: 36.h,
      padding: EdgeInsets.all(8.h),
      decoration: BoxDecoration(
        color: getBackgroundColor(),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: getCallIcon(isCaller: isCaller, callType: callType),
      ),
    );
  }

  Widget getCallIcon({required bool isCaller, required CallType callType}) {
    // use Icons material
    final iconSize = 21.h;
    switch (this) {
      case CallStatusType.ringing:
        return isCaller
            ? callType == CallType.video
                ? Icon(
                    Icons.video_call,
                    color: Colors.white,
                    size: iconSize,
                  )
                : Icon(
                    Icons.call_made_rounded,
                    color: Colors.white,
                    size: iconSize,
                  )
            : callType == CallType.video
                ? Icon(
                    Icons.video_call,
                    color: Colors.white,
                    size: iconSize,
                  )
                : Icon(
                    Icons.call_received_rounded,
                    color: Colors.white,
                    size: iconSize,
                  );
      case CallStatusType.accepted:
      case CallStatusType.started:
        return callType == CallType.video
            ? Icon(
                Icons.emergency_recording,
                color: Colors.white,
                size: iconSize,
              )
            : Assets.svg.icCallStarted.svg(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn));
      case CallStatusType.ended:
        return callType == CallType.video
            ? Icon(
                Icons.video_call,
                color: Colors.white,
                size: iconSize,
              )
            : Assets.svg.icCallEnded.svg(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn));
      case CallStatusType.rejected:
        return callType == CallType.video
            ? Assets.svg.icVideoRejected.svg(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn))
            : Assets.svg.icCallRejected.svg(
                colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn));
      case CallStatusType.unanswered:
        return Icon(
          callType == CallType.video
              ? Icons.missed_video_call_rounded
              : isCaller
                  ? Icons.call_missed_outgoing_rounded
                  : Icons.call_missed_rounded,
          color: Colors.white,
          size: 21.h,
        );
    }
  }

  Color getBackgroundColor() {
    switch (this) {
      case CallStatusType.ringing:
      case CallStatusType.accepted:
      case CallStatusType.started:
        return Colors.green;
      case CallStatusType.ended:
        return Colors.grey;
      case CallStatusType.rejected:
      case CallStatusType.unanswered:
        return Colors.red;
    }
  }
}
