// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BaseErrorResponse _$$_BaseErrorResponseFromJson(Map<String, dynamic> json) =>
    _$_BaseErrorResponse(
      errorMessage: json['error_message'] as String?,
      status: json['status'] as bool?,
      code: json['code'] as String?,
    );

Map<String, dynamic> _$$_BaseErrorResponseToJson(
        _$_BaseErrorResponse instance) =>
    <String, dynamic>{
      'error_message': instance.errorMessage,
      'status': instance.status,
      'code': instance.code,
    };
