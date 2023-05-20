import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:flutter/material.dart';

class MessageController extends BaseController {
  TextEditingController searchController = TextEditingController();
  RxString avatarUrl = RxString('');
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
}
