// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentModel _$$_PaymentModelFromJson(Map<String, dynamic> json) =>
    _$_PaymentModel(
      paymentId: json['payment_id'] as String?,
      userId: json['user_id'] as String?,
      status: $enumDecodeNullable(_$PaymentStatusTypeEnumMap, json['status']),
      paymentMethod: json['payment_method'] as String?,
      transactionId: json['transaction_id'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      createAt: json['create_at'] == null
          ? null
          : DateTime.parse(json['create_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      updateAt: json['update_at'] == null
          ? null
          : DateTime.parse(json['update_at'] as String),
      subscriptionPackage: json['subscription_package'] == null
          ? null
          : SubscriptionPackageModel.fromJson(
              json['subscription_package'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PaymentModelToJson(_$_PaymentModel instance) =>
    <String, dynamic>{
      'payment_id': instance.paymentId,
      'user_id': instance.userId,
      'status': _$PaymentStatusTypeEnumMap[instance.status],
      'payment_method': instance.paymentMethod,
      'transaction_id': instance.transactionId,
      'created_at': instance.createdAt?.toIso8601String(),
      'create_at': instance.createAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'update_at': instance.updateAt?.toIso8601String(),
      'subscription_package': instance.subscriptionPackage,
    };

const _$PaymentStatusTypeEnumMap = {
  PaymentStatusType.pending: 'pending',
  PaymentStatusType.success: 'success',
  PaymentStatusType.failed: 'failed',
};
