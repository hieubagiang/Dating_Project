// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_recommendation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRecommendationResponse _$GetRecommendationResponseFromJson(
        Map<String, dynamic> json) =>
    GetRecommendationResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetRecommendationResponseToJson(
        GetRecommendationResponse instance) =>
    <String, dynamic>{
      'data': instance.data?.map((e) => e.toJson()).toList(),
      'pagination': instance.pagination?.toJson(),
    };
