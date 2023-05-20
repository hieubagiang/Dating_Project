import 'package:dating_app/app/data/models/pagination.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../base/base_data.dart';
import '../../models/payment/payment_model.dart';
import '../../request/payment/payment_request.dart';
import '../../response/create_payment_response.dart';
import '../../response/get_payment_history_response.dart';

part 'payment_api.g.dart';

@RestApi()
abstract class PaymentApi {
  factory PaymentApi(Dio dio, {String baseUrl}) = _PaymentApi;

  @POST("/api/payment/payment_process")
  Future<BaseData<CreatePaymentResponse>> createPaymentLink(
    @Body() PaymentRequest request,
  );

  @GET("/api/payment/histories/{payment_id}")
  Future<BaseData<PaymentModel>> getPaymentDetail({
    @Path('payment_id') required String paymentId,
  });

  @GET("/api/payment/histories")
  Future<BaseData<GetPaymentHistoryResponse>> getPaymentHistory({
    @Queries() required Pagination request,
  });
}
