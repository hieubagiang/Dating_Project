import 'dart:ui';

import 'package:dating_app/app/translations/vi_VN/vi_vn_translations.dart';
import 'package:easy_localization/easy_localization.dart';

import 'en_US/en_us_translations.dart';

abstract class AppTranslation {
  static Map<String, Map<String, String>> translations = {
    'en': enUs,
    'vi': viVn,
  };
}

class RuntimeLanguageLoader extends AssetLoader {
  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(AppTranslation.translations[locale.languageCode]);
  }
}
