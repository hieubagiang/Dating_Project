import 'package:get/get.dart';

import 'chosen_tab_controller.dart';

class ChosenTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChosenTabController());
  }
}
