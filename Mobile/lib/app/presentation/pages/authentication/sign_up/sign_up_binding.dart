import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:get/get.dart';

import 'sign_up_controller.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StorageRepository());
    Get.lazyPut(() => UserRepository());
    Get.lazyPut(() => CommonController());
    Get.lazyPut(() => SignUpController());
  }
}
