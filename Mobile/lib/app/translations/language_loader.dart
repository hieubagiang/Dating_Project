// import 'package:easy_localization_loader/easy_localization_loader.dart';
// import 'package:flutter/foundation.dart';
//
// import '../common/configs/default_env.dart';
// import '../common/constants/constants.dart';
// import 'runtime_language_loader.dart';
//
// Object languageLoader() {
//   /// Nếu là debug thì ưu tiên load từ file ngôn ngữ trong assets của dev
//   if (kDebugMode) {
//     return CustomRootBundleAssetLoader();
//   }
//
//   /// Nếu là release thì load từ file ngôn ngữ từ server
//   /// Hiện tại config là không cache, nên mỗi lần load lại sẽ phải load từ server
//   /// Nếu muốn cache thì sửa lại tham số localCacheDuration cho phù hợp
//   return SmartNetworkAssetLoader(
//     assetsPath: LocalizationConstants.path,
//     localCacheDuration: const Duration(seconds: 1),
//     localeUrl: (String localeName) => DefaultConfig.getAppLanguageUrl,
//   );
// }
