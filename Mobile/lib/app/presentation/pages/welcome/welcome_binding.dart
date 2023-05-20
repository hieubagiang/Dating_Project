import 'package:dating_app/app/presentation/pages/authentication/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

import 'welcome_controller.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeController());
    Get.lazyPut(() => SignInController());
  }
}
