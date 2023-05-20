import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/data/models/subscription_package_model/subscription_package_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../enums/payment_status_enum.dart';

part 'payment_model.freezed.dart';
part 'payment_model.g.dart';

@freezed
class PaymentModel with _$PaymentModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  factory PaymentModel({
    String? paymentId,
    String? userId,
    PaymentStatusType? status,
    String? paymentMethod,
    String? transactionId,
    DateTime? createdAt,
    DateTime? createAt,
    DateTime? updatedAt,
    DateTime? updateAt,
    SubscriptionPackageModel? subscriptionPackage,
  }) = _PaymentModel;

  const PaymentModel._();
  factory PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentModelFromJson(json);

  factory PaymentModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      PaymentModel.fromJson(snapshot.data() ?? {});

  DateTime? getCreatedAt() => createdAt ?? createAt;
  DateTime? getUpdatedAt() => updatedAt ?? updateAt;
}
