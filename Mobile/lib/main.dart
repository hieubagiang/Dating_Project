import 'package:dating_app/app.dart';
import 'package:dating_app/firebase_options.dart';
import 'package:dating_app/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:money2/money2.dart';

import 'app/common/constants/constants.dart';
import 'app/common/helper/local_notification_helper.dart';
import 'app/data/models/user_model/user_model.dart';
import 'app/data/repositories/user_repository.dart';
import 'app/di/di_setup.dart';
import 'app/presentation/pages/app/app_binding.dart';
import 'app/translations/runtime_language_loader.dart';

String envConfig(String flavor) {
  switch (flavor) {
    case 'dev':
      return const $AssetsEnvGen().envDev;
    case 'staging':
      return const $AssetsEnvGen().envStaging;
    case 'production':
      return const $AssetsEnvGen().envProduction;
    default:
      return const $AssetsEnvGen().envStaging;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const flavor = String.fromEnvironment('flavor', defaultValue: 'dev');
  await dotenv.load(fileName: envConfig(flavor));

  await LocalNotificationHelper().init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  await firebaseAppCheck.activate(
    androidProvider:
        kDebugMode ? AndroidProvider.debug : AndroidProvider.playIntegrity,
  );
  configureDependencies();

  AppBinding().dependencies();
  await FlutterDownloader.initialize(debug: true);
  UserModel? currentUser = await UserRepository().getUser();
  // await AdHelper.initialize();
  Currencies().register(
    Currency.create(
      'VND',
      0,
    ),
  );

  runApp(EasyLocalization(
      startLocale: LocalizationConstants.viLocale,
      supportedLocales: const [
        LocalizationConstants.viLocale,
        LocalizationConstants.enUSLocale,
      ],
      path: LocalizationConstants.path,
      assetLoader: RuntimeLanguageLoader(),
      fallbackLocale: LocalizationConstants.enUSLocale,
      child: MyApp(currentUser: currentUser)));
  ;
}
