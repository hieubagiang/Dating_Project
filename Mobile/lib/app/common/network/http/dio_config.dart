/*

Dio dioProduct = Dio(BaseOptions(
  connectTimeout: Configurations.connectTimeout,
  receiveTimeout: Configurations.responseTimeout,
  contentType: Configurations.contentType,
  headers: {'Accept': 'application/json'},
  baseUrl: Configurations.productHost,
))
  ..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      request: true,
      error: true,
      compact: true,
      maxWidth: 90));
*/
/*
LogInterceptor logInterceptor = LogInterceptor(
  requestHeader: kDebugMode,
  requestBody: kDebugMode,
  responseBody: kDebugMode,
  responseHeader: false,
);*/
