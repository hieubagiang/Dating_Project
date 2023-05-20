import 'package:dating_app/app/common/configs/configurations.dart';
import 'package:dio/dio.dart';

import '../../data/provider/dio_interceptor.dart';
import '../constants/constants.dart';
import '../helper/pretty_dio_logger.dart';

class DioBuilder {
  Dio? dio;
  Dio getDio() {
    if (dio == null) {
      final BaseOptions options = BaseOptions(
        baseUrl: getUrl(),
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: ApiConfig.connectTimeout),
        receiveTimeout: const Duration(seconds: ApiConfig.responseTimeout),
        headers: {"Accept": "Application/json"},
      );
      dio = Dio(options);
      dio?.options.headers['content-Type'] = 'Application/json';
      dio?.interceptors.addAll(
        [
          DioInterceptor(),
          PrettyDioLogger(
            requestHeader: true,
            requestBody: true,
            responseBody: true,
            responseHeader: true,
            request: true,
            error: true,
            compact: true,
            maxWidth: 90,
          ),
        ],
      );
    }
    return dio!;
  }

  String getUrl() {
    return Configurations.apiBaseUrl;
  }
}
