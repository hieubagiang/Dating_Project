import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ErrorHandling implements Exception {
  final Dio dio = Get.find<Dio>();

  ErrorHandling.withError({
    required DioError error,
  }) {
    _handleError(error);
  }

  Future _handleError(DioError error) async {
    String errorMessage = "";
    switch (error.type) {
      case DioErrorType.cancel:
        errorMessage = "dio_cancel_request".tr;
        break;
      case DioErrorType.connectionTimeout:
        errorMessage = "dio_cancel_request".tr;
        break;
      case DioErrorType.unknown:
        errorMessage = "dio_cancel_request".tr;
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = "dio_cancel_request".tr;
        break;
      case DioErrorType.sendTimeout:
        errorMessage = "dio_cancel_request".tr;
        break;
      case DioErrorType.badResponse:
        final code = error.response?.statusCode;

        //handle refresh Token
        // if (error.type == StatusCode.refreshToken){
        //   await refreshToken(error);
        //   return;
        // }
        // if (code == StatusCode.unauthorized) {
        //   errorMessage = "unauthorized";
        // } else {
        //   //todo: handle message =>
        // }
        break;
      default:
        break;
    }
    return errorMessage;
  }

  Future<void> refreshToken(DioError error) async {
    error.requestOptions.cancelToken?.cancel();
    String token = "";
    //get new Token
    final headers = error.requestOptions.headers;
    headers['Authorization'] = token;
    final opts = Options(method: error.requestOptions.method, headers: headers);
    await dio.request(
      error.requestOptions.path,
      options: opts,
      data: error.requestOptions.data,
      queryParameters: error.requestOptions.queryParameters,
    );
  }
}
