import 'package:get/get.dart';

import 'liked_tab_controller.dart';

class LikedTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LikedTabController());
  }
}
