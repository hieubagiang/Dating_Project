import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'error.dart';

extension DioErrorMessage on DioError {
  BaseError get baseError {
    BaseError errorMessage = BaseError.httpUnknownError("error_system".tr);
    switch (type) {
      case DioErrorType.cancel:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr);
        break;
      case DioErrorType.connectionTimeout:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr);
        break;
      case DioErrorType.unknown:
        if (error != null && error is SocketException) {
          errorMessage =
              BaseError.httpInternalServerError('no_internet_access'.tr);
        }
        break;
      case DioErrorType.receiveTimeout:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr);
        break;
      case DioErrorType.sendTimeout:
        errorMessage = BaseError.httpUnknownError("dio_cancel_request".tr);
        break;
      case DioErrorType.badResponse:
        // try {
        //   ErrorResponse errorResponse = ErrorResponse.fromJson(response?.data);
        //   final code = errorResponse.data?.errors?.first.errorCode;
        //   if (code == StatusCodeEnum.unauthorized) {
        //     errorMessage = const BaseError.httpUnAuthorizedError();
        //
        //     ///Call event app_hash expired
        //     getIt<EventBus>().fire(AppHashExpiredEvent());
        //   } else {
        //     errorMessage = code?.message ??
        //         BaseError.httpInternalServerError("error_system".tr);
        //   }
        // } catch (e) {
        //   errorMessage = BaseError.httpInternalServerError("error_system".tr);
        // }
        break;
      default:
        errorMessage = BaseError.httpUnknownError("error_system".tr);
        break;
    }
    return errorMessage;
  }
}

extension BaseErrorMessage on BaseError {
  String get getErrorString {
    if (this is HttpInternalServerError) {
      return (this as HttpInternalServerError).errorBody;
    } else if (this is HttpUnAuthorizedError) {
      return "error_system".tr;
    } else if (this is HttpUnknownError) {
      return (this as HttpUnknownError).message;
    }
    return "error_system".tr; //todo: specify error string
  }
}
