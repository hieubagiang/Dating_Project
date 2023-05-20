import 'package:dating_app/app/data/repositories/message_repository.dart';
import 'package:get/get.dart';

import 'message_list_controller.dart';

class MessageListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatRepositoryImpl());
    Get.lazyPut(() => MessageListController());
  }
}
