// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseDataResponse _$BaseDataResponseFromJson(Map<String, dynamic> json) =>
    BaseDataResponse(
      error: json['error'] == null
          ? null
          : ErrorResponse.fromJson(json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseDataResponseToJson(BaseDataResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
    };
