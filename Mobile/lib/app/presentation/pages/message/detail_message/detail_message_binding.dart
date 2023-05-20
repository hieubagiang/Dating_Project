import 'package:get/get.dart';

import '../../../../data/repositories/message_repository.dart';
import 'detail_message_controller.dart';

class DetailMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRepositoryImpl());

    Get.lazyPut(() => DetailMessageListController());
  }
}
