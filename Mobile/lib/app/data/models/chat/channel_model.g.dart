// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChannelModel _$ChannelModelFromJson(Map<String, dynamic> json) => ChannelModel(
      channelId: json['channel_id'] as String?,
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => MemberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      memberIds: (json['member_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      messages: (json['messages'] as List<dynamic>?)
          ?.map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastMessage: json['last_message'] == null
          ? null
          : MessageModel.fromJson(json['last_message'] as Map<String, dynamic>),
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
    );

Map<String, dynamic> _$ChannelModelToJson(ChannelModel instance) =>
    <String, dynamic>{
      'channel_id': instance.channelId,
      'members': instance.members?.map((e) => e.toJson()).toList(),
      'member_ids': instance.memberIds,
      'messages': instance.messages?.map((e) => e.toJson()).toList(),
      'last_message': instance.lastMessage?.toJson(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': ChannelModel.coordinatesToJson(instance.updateAt),
    };
