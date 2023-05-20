// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'matched_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchedUserModel _$MatchedUserModelFromJson(Map<String, dynamic> json) =>
    MatchedUserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
      birthday: DateTime.parse(json['birthday'] as String),
      avatarUrl: json['avatar_url'] as String,
      location: json['location'] == null
          ? null
          : PositionModel.fromJson(json['location'] as Map<String, dynamic>),
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
    );

Map<String, dynamic> _$MatchedUserModelToJson(MatchedUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'username': instance.username,
      'birthday': instance.birthday.toIso8601String(),
      'avatar_url': instance.avatarUrl,
      'location': instance.location?.toJson(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': MatchedUserModel.updateAtToJson(instance.updateAt),
    };
