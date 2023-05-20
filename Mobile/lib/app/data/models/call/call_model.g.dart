// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'call_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CallModel _$$_CallModelFromJson(Map<String, dynamic> json) => _$_CallModel(
      callId: json['call_id'] as String?,
      channelId: json['channel_id'] as String?,
      callerId: json['caller_id'] as String?,
      messageId: json['message_id'] as String?,
      caller: json['caller'] == null
          ? null
          : BasicUserModel.fromJson(json['caller'] as Map<String, dynamic>),
      receiverId: json['receiver_id'] as String?,
      receiver: json['receiver'] == null
          ? null
          : BasicUserModel.fromJson(json['receiver'] as Map<String, dynamic>),
      callStatus:
          $enumDecodeNullable(_$CallStatusTypeEnumMap, json['call_status']),
      callType: $enumDecodeNullable(_$CallTypeEnumMap, json['call_type']),
      startTime: json['start_time'] == null
          ? null
          : DateTime.parse(json['start_time'] as String),
      endTime: json['end_time'] == null
          ? null
          : DateTime.parse(json['end_time'] as String),
      createAt: json['create_at'] == null
          ? null
          : DateTime.parse(json['create_at'] as String),
      updateAt: json['update_at'] == null
          ? null
          : DateTime.parse(json['update_at'] as String),
    );

Map<String, dynamic> _$$_CallModelToJson(_$_CallModel instance) =>
    <String, dynamic>{
      'call_id': instance.callId,
      'channel_id': instance.channelId,
      'caller_id': instance.callerId,
      'message_id': instance.messageId,
      'caller': instance.caller?.toJson(),
      'receiver_id': instance.receiverId,
      'receiver': instance.receiver?.toJson(),
      'call_status': _$CallStatusTypeEnumMap[instance.callStatus],
      'call_type': _$CallTypeEnumMap[instance.callType],
      'start_time': instance.startTime?.toIso8601String(),
      'end_time': instance.endTime?.toIso8601String(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
    };

const _$CallStatusTypeEnumMap = {
  CallStatusType.ringing: 'ringing',
  CallStatusType.accepted: 'accepted',
  CallStatusType.started: 'started',
  CallStatusType.ended: 'ended',
  CallStatusType.rejected: 'rejected',
  CallStatusType.unanswered: 'unanswered',
};

const _$CallTypeEnumMap = {
  CallType.voice: 'voice',
  CallType.video: 'video',
};
