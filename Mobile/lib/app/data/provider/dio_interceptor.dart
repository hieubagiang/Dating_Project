import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart' hide Response;

import '../../common/configs/configurations.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //check base url is match default config base url
    if (options.baseUrl == Configurations.apiBaseUrl) {
      //set auth token from Firebase Auth
      options.headers['Authorization'] =
          'Bearer ${await FirebaseAuth.instance.currentUser?.getIdToken()}';
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    handler.next(response);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    //TODO : check sau
    // if (err.type == DioErrorType.unknown) {
    //   if (err.message == 'Unexpected end of input') {
    //     // String data = exception.source + '}';
    //     return handler.resolve(Response(
    //         requestOptions: err.requestOptions, data: jsonDecode(data)));
    //   }
    // }
    if (err.type == DioErrorType.unknown) {
      Get.find<CommonController>().hideLoading();
    }
    return handler.reject(err);
    return handler.next(err);
  }
}
