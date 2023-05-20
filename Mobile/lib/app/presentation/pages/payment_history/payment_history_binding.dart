import 'package:get/get.dart';

import 'payment_history_controller.dart';

class PaymentHistoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PaymentHistoriesController());
  }
}
