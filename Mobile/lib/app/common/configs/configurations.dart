import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configurations {
  static const String webHomePage = 'http://dating.hieuit.top';
  static String get apiBaseUrl => dotenv.get('BASE_URL');
  static String get apiProductBaseUrl => 'https://api.dating.hieuit.top';
  static String get returnEndpoint => '/api/payment/payment_return';
  static const String policyLink = '$webHomePage/policy';
  static const int adsCount = 5;
}
