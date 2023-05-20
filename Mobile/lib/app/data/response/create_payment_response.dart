import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/payment/payment_model.dart';

part 'create_payment_response.freezed.dart';
part 'create_payment_response.g.dart';

@freezed
class CreatePaymentResponse with _$CreatePaymentResponse {
  const factory CreatePaymentResponse({
    @JsonKey(name: "payment_model") PaymentModel? paymentModel,
    @JsonKey(name: "payment_url") String? paymentUrl,
  }) = _CreatePaymentResponse;

  factory CreatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$CreatePaymentResponseFromJson(json);
}
