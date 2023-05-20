// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'boost_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoostModel _$BoostModelFromJson(Map<String, dynamic> json) => BoostModel(
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
      userId: json['user_id'] as String,
      expireAt: DateTimeUtils.dateTimeFromJson(json['expire_at']),
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
    );

Map<String, dynamic> _$BoostModelToJson(BoostModel instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'expire_at': instance.expireAt?.toIso8601String(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': BoostModel.coordinatesToJson(instance.updateAt),
    };
