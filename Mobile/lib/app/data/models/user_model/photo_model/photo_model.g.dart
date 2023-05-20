// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhotoModel _$PhotoModelFromJson(Map<String, dynamic> json) => PhotoModel(
      id: json['id'] as int,
      url: json['url'] as String,
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
    );

Map<String, dynamic> _$PhotoModelToJson(PhotoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': PhotoModel.coordinatesToJson(instance.updateAt),
    };
