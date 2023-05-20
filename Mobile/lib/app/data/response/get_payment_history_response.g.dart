// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_payment_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetPaymentHistoryResponse _$$_GetPaymentHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    _$_GetPaymentHistoryResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PaymentModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination: json['pagination'] == null
          ? null
          : Pagination.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_GetPaymentHistoryResponseToJson(
        _$_GetPaymentHistoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'pagination': instance.pagination,
    };
