import 'package:dating_app/app/presentation/pages/authentication/sign_in/sign_in_controller.dart';
import 'package:get/get.dart';

import 'sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
  }
}
