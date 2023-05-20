import 'package:freezed_annotation/freezed_annotation.dart';
part 'payment_request.freezed.dart';
part 'payment_request.g.dart';

@freezed
class PaymentRequest with _$PaymentRequest {
  const factory PaymentRequest({
    @JsonKey(name: "user_id") String? userId,
    @JsonKey(name: "premium_package") String? premiumPackage,

  }) = _PaymentRequest;

  factory PaymentRequest.fromJson(Map<String, dynamic> json) => _$PaymentRequestFromJson(json);
}

