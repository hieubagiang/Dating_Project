import 'package:get/get.dart';

import 'top_picks_tab_controller.dart';

class TopPicksTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TopPicksTabController());
  }
}
