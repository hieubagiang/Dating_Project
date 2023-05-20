import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:money2/money2.dart';

part 'subscription_package_model.freezed.dart';
part 'subscription_package_model.g.dart';

@freezed
class SubscriptionPackageModel with _$SubscriptionPackageModel {
  const factory SubscriptionPackageModel({
    @JsonKey(name: "duration_in_days") int? durationInDays,
    int? price,
    String? name,
    String? slug,
  }) = _SubscriptionPackageModel;

  const SubscriptionPackageModel._();

  factory SubscriptionPackageModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionPackageModelFromJson(json);

  factory SubscriptionPackageModel.fromQueryDocumentSnapshot(
    QueryDocumentSnapshot documentSnapshot,
  ) =>
      SubscriptionPackageModel.fromJson(
        documentSnapshot.data()! as Map<String, dynamic>,
      );

  static List<SubscriptionPackageModel> fromQuerySnapshot(
    QuerySnapshot querySnapshot,
  ) =>
      querySnapshot.docs
          .map(
            (documentSnapshot) => SubscriptionPackageModel.fromJson(
              documentSnapshot.data()! as Map<String, dynamic>,
            ),
          )
          .toList();

  String get formattedPrice => price != null
      ? Money.fromInt(
          price ?? 0,
          code: "VNĐ",
        ).format('###,###,### CCC')
      : "";
}
