// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CreatePaymentResponse _$$_CreatePaymentResponseFromJson(
        Map<String, dynamic> json) =>
    _$_CreatePaymentResponse(
      paymentModel: json['payment_model'] == null
          ? null
          : PaymentModel.fromJson(
              json['payment_model'] as Map<String, dynamic>),
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$$_CreatePaymentResponseToJson(
        _$_CreatePaymentResponse instance) =>
    <String, dynamic>{
      'payment_model': instance.paymentModel,
      'payment_url': instance.paymentUrl,
    };
