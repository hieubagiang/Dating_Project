import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:get/get.dart';

import 'edit_controller.dart';

class EditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageRepository());
    Get.lazyPut(() => EditController());
  }
}
