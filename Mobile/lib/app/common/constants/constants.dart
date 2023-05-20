//Notification
import 'dart:ui';

class LocalizationConstants {
  static const Locale viLocale = Locale('vi', 'VN');
  static const Locale enUSLocale = Locale('en', 'US');
  static const path = 'assets/translations';
  static String appLanguageEndpoint = '/languages/';
}

class ConstantsUtils {
  /// Common Constants
  static const String language = 'LANGUAGE';
  static const int clickDelay = 500;

  //API
  static const int pageSize = 10;

  //IMAGE
  static const int imageMaxWidth = 1600;
  static const int imageSmallMaxWidth = 400;
  static const int imageQuality = 80;

  //LOGIN
  static const String accessTokenKey = 'ACCESS_TOKEN_KEY';
  static const String loginIdKey = 'LOGIN_ID';

  static const String chatApiKey = '2yfe9sav467x';

  static const int dbVersion = 1;
}

class ApiConfig {
  static const int connectTimeout = 30000;
  static const int responseTimeout = 30000;
  static const String contentType = 'application/json; charset=utf-8';
  static const String authentication = 'Authorization';
  static String host = '';
}

class Config {
  static const memCacheHeight = 3000;
  static const memCacheWidth = 3000;
  static const defaultDurationShowToast = 2; //seconds
}
