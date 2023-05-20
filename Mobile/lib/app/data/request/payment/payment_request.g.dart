// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentRequest _$$_PaymentRequestFromJson(Map<String, dynamic> json) =>
    _$_PaymentRequest(
      userId: json['user_id'] as String?,
      premiumPackage: json['premium_package'] as String?,
    );

Map<String, dynamic> _$$_PaymentRequestToJson(_$_PaymentRequest instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'premium_package': instance.premiumPackage,
    };
