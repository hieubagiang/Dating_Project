import 'package:get/get.dart';

import 'verify_phone_number_controller.dart';

class VerifyPhoneNumberBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyPhoneNumberController());
  }
}
