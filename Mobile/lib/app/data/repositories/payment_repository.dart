import 'package:dating_app/app/common/base/errors/extension.dart';
import 'package:dating_app/app/data/models/pagination.dart';
import 'package:dating_app/app/data/provider/payment_api/payment_api.dart';
import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../common/base/errors/error.dart';
import '../base/base_error.dart';
import '../models/payment/payment_model.dart';
import '../request/payment/payment_request.dart';
import '../response/create_payment_response.dart';

class PaymentRepository {
  final PaymentApi api = Get.find<PaymentApi>();

  Future<CreatePaymentResponse?> createPaymentLink(
      PaymentRequest request) async {
    try {
      final result = await api.createPaymentLink(
        request,
      );
      return result.data;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  Future<Either<BaseErrorResponse, PaymentModel>> getPaymentDetail({
    required String paymentId,
  }) async {
    try {
      final result = await api.getPaymentDetail(
        paymentId: paymentId,
      );
      if (result.data == null) {
        return Left(BaseErrorResponse.fromBaseData(result));
      }
      return Right(result.data!);
    } catch (exception) {
      debugPrint(exception.toString());
      return Left(BaseErrorResponse.defaultError());
    }
  }

  Future<Either<BaseError, List<PaymentModel>>> getPaymentHistory(
      {required Pagination request}) async {
    try {
      final result = await api.getPaymentHistory(request: request);
      if (result.data == null) {
        return const Left(BaseError.httpUnknownError('Data is null'));
      }
      return Right(result.data?.data ?? []);
    } on DioError catch (e) {
      return Left(e.baseError);
    }
  }
}
