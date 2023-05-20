// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PositionModel _$PositionModelFromJson(Map<String, dynamic> json) =>
    PositionModel(
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      address: json['address'] as String?,
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
    );

Map<String, dynamic> _$PositionModelToJson(PositionModel instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': PositionModel.coordinatesToJson(instance.updateAt),
    };
