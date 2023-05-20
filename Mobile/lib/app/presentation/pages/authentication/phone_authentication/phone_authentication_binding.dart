import 'package:get/get.dart';

import 'phone_authentication_controller.dart';

class PhoneAuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PhoneAuthenticationController());
  }
}
