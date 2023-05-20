import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dating_app/app/common/helper/pretty_dio_logger.dart';
import 'package:dating_app/app/data/base/api_response.dart';
import 'package:dio/dio.dart';

import 'dio_interceptor.dart';

class Method {
  static const get = 'get';
  static const post = 'post';
  static const put = 'put';
  static const delete = 'DELETE';
}

class Api {
  late Dio client;
  late String baseUrl;

  Api({String? baseUrl}) {
    baseUrl ??= 'https://us-central1-tinder-clone-36718.cloudfunctions.net';

    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 45 * 1000),
      receiveTimeout: Duration(seconds: 45 * 1000),
      headers: {"Accept": "application/json"},
    );
    client = Dio(options);
    client.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        request: true,
        error: true,
        compact: true,
        maxWidth: 90));
    client.interceptors.add(DioInterceptor());
  }

  void close() => client.close();

  // get Request
  Future<dynamic> baseRequest(
      {String method = Method.get,
      String url = '',
      dynamic params,
      Map<String, dynamic> queryParameters = const {},
      Map<String, String> headers = const {},
      bool getRawResponse = false,
      String? token,
      bool isGuestMode = false}) async {
    try {
      if (token != null) {
        client.options.headers["Authorization"] = "Bearer $token";
      }
      if (headers != {}) {
        client.options.headers.addAll(headers);
      }
      ApiResponse? dataResponse;

      switch (method) {
        case Method.get:
          Response response = await client.get(
            url,
            queryParameters: queryParameters,
          );
          if (getRawResponse) {
            return response.data;
          }
          dataResponse = ApiResponse.fromJson(response.data);

          break;

        case Method.post:
          Response response = await client.post(url,
              queryParameters: queryParameters, data: params);
          if (getRawResponse) {
            return response.data;
          }
          dataResponse = ApiResponse.fromJson(response.data);
          break;
        case Method.put:
          Response response = await client.put(url,
              queryParameters: queryParameters, data: params);
          if (getRawResponse) {
            return response.data;
          }
          dataResponse = ApiResponse.fromJson(response.data);
          break;
      }

      return dataResponse;
    } on DioError catch (ex) {
      if (ex.type == DioErrorType.connectionTimeout) {
        print("Connection  Timeout Exception");
      }
      if (ex.response == null) {
        return ApiResponse.fromJson(
            {"success": false, "error": "server_error"});
      }
      var resData = ex.response!.data;
      return ApiResponse.fromJson(resData);
      // throw Exception(ex.message);
    } catch (e) {
      print('e catch: ${e.toString()}');
      //check has internet connection
      var connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        print('Error: Server!');
        return ApiResponse.fromJson(
            {"success": false, "error": "server_error"});
      }

      print('Error: Network!');
      return ApiResponse.fromJson({"success": false, "error": "network_error"});
    }
  }
}
