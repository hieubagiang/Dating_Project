import 'package:get/get.dart';
import 'loader_controller.dart';

class LoaderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CommonController());
  }
}
