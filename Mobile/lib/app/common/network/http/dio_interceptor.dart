import 'package:dio/dio.dart';

class DioInterceptor extends Interceptor {
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    handler.next(err);
  }

/*  Future _handleRefreshToken(DioError err) async {
    RequestOptions options = err.response!.requestOptions;

    final refreshToken =
        await Injector.container<AppPreference>().getRefreshToken();
    final response = await Injector.container<AuthenticationRepository>()
        .refreshToken(RefreshTokenRequest(
            grantType: AuthenticationGrantType.refresh_token.key,
            refreshToken: refreshToken));
    final tokenModel = LoginModel.parseModel(response);
    Injector.container<AppPreference>()
        .saveToken(tokenModel.accessToken, tokenModel.refreshToken);
    options.headers[Configurations.authentication] =
        Configurations.getBearerAuth(response.accessToken);
    return dio.request(options.path, options: options);
  }
*/

}
