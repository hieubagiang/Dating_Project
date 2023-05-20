import 'package:dating_app/app/data/models/pagination.dart';
import 'package:dating_app/app/data/models/payment/payment_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'get_payment_history_response.freezed.dart';
part 'get_payment_history_response.g.dart';

@freezed
class GetPaymentHistoryResponse with _$GetPaymentHistoryResponse {
  const factory GetPaymentHistoryResponse({
    List<PaymentModel>? data,
    Pagination? pagination,
  }) = _GetPaymentHistoryResponse;

  factory GetPaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$GetPaymentHistoryResponseFromJson(json);
}
