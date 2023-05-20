import 'package:intl/intl.dart';

class CurrencyConstants {
  static final NumberFormat viFormatter = NumberFormat.currency(
    locale: 'vi',
    symbol: '₫',
    decimalDigits: 0,
  );
}
