// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_package_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SubscriptionPackageModel _$$_SubscriptionPackageModelFromJson(
        Map<String, dynamic> json) =>
    _$_SubscriptionPackageModel(
      durationInDays: json['duration_in_days'] as int?,
      price: json['price'] as int?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
    );

Map<String, dynamic> _$$_SubscriptionPackageModelToJson(
        _$_SubscriptionPackageModel instance) =>
    <String, dynamic>{
      'duration_in_days': instance.durationInDays,
      'price': instance.price,
      'name': instance.name,
      'slug': instance.slug,
    };
