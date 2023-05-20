// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interacted_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InteractedUserModel _$InteractedUserModelFromJson(Map<String, dynamic> json) =>
    InteractedUserModel(
      currentUser: MatchedUserModel.fromJson(
          json['current_user'] as Map<String, dynamic>),
      interactedUser: MatchedUserModel.fromJson(
          json['interacted_user'] as Map<String, dynamic>),
      interactedType: json['interacted_type'] as int,
      updateAt: DateTime.parse(json['update_at'] as String),
      currentUserId: json['current_user_id'] as String,
      interactedUserId: json['interacted_user_id'] as String,
      chatChannelId: json['chat_channel_id'] as String?,
    );

Map<String, dynamic> _$InteractedUserModelToJson(
        InteractedUserModel instance) =>
    <String, dynamic>{
      'current_user_id': instance.currentUserId,
      'current_user': instance.currentUser.toJson(),
      'interacted_user_id': instance.interactedUserId,
      'interacted_user': instance.interactedUser.toJson(),
      'interacted_type': instance.interactedType,
      'update_at': instance.updateAt.toIso8601String(),
      'chat_channel_id': instance.chatChannelId,
    };
