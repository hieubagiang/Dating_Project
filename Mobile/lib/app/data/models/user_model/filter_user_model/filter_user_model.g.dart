// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedFilterModel _$FeedFilterModelFromJson(Map<String, dynamic> json) =>
    FeedFilterModel(
      createAt: DateTimeUtils.dateTimeFromJson(json['create_at']),
      updateAt: DateTimeUtils.dateTimeFromJson(json['update_at']),
      distance: (json['distance'] as num?)?.toDouble(),
      interestedInGender: json['interested_in_gender'] as int?,
      ageRange: json['age_range'] == null
          ? null
          : AgeRangeModel.fromJson(json['age_range'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedFilterModelToJson(FeedFilterModel instance) =>
    <String, dynamic>{
      'distance': instance.distance,
      'interested_in_gender': instance.interestedInGender,
      'age_range': instance.ageRange?.toJson(),
      'create_at': instance.createAt?.toIso8601String(),
      'update_at': FeedFilterModel.coordinatesToJson(instance.updateAt),
    };
