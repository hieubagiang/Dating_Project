import 'package:get/get.dart';

import 'vn_pay_controller.dart';

class VnPayBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VnPayController());
  }
}
