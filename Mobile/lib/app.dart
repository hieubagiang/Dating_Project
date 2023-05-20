import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import 'app/data/models/user_model/user_model.dart';
import 'app/presentation/pages/app/app_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/translations/app_translations.dart';
import 'app/widgets/loader_widget/loader_screen.dart';

class MyApp extends StatelessWidget {
  final UserModel? currentUser;

  const MyApp({Key? key, this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CommonController(), permanent: true);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return FirebasePhoneAuthProvider(
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            initialBinding: AppBinding(),
            getPages: AppPages.pages,
            translations: MyTranslations(),
            fallbackLocale: MyTranslations.fallbackLocale,
            theme: ThemeData(
              primarySwatch: Colors.pink,
            ),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,

            navigatorObservers: [FlutterSmartDialog.observer],
            // initialRoute: RouteList.signUp,
            initialRoute: FirebaseAuth.instance.currentUser == null
                ? RouteList.welcome
                : (currentUser != null ||
                        FirebaseAuth.instance.currentUser!.isAnonymous)
                    ? RouteList.main
                    : RouteList.signUp,
            /*
              FirebaseAuth.instance.currentUser == null
                  ? RouteList.welcome
                  : RouteList.signUp*/
            builder: FlutterSmartDialog.init(
              builder: (context, child) {
                return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: LoadingContainer(
                    key: const ValueKey('LoadingContainer'),
                    child: child,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
