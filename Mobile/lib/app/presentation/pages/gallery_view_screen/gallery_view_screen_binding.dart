import 'package:get/get.dart';

import 'gallery_view_screen_controller.dart';

class GalleryViewScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => GalleryViewScreenController());
  }
}
