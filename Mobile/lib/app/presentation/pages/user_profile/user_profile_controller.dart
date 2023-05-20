import 'dart:convert';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/args/user_profile_args.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/presentation/pages/feed/controller/feed_controller.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';

class UserProfileController extends BaseController {
  Rx<UserModel> selectedUser = Rx((Get.arguments as UserProfileArgs).model);
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  Rx<String?> address = Rx(null);
  String heroTag = (Get.arguments as UserProfileArgs).heroTag;

  @override
  Future<void> onInit() async {
    withScrollController = true;
    super.onInit();
    selectedUser.value = selectedUser.value;
    address.value = selectedUser.value.isFakeData
        ? await selectedUser.value.getAddress()
        : selectedUser.value.location?.address ?? '';
    FunctionUtils.logWhenDebug(this, jsonEncode(selectedUser.value.toJson()));
    scrollController.addListener(() {
      if (scrollController.offset < -50) {
        Get.back();
      }
    });
  }

  void onTapInteractingActionButton(InteractType type) {
    Get.back();
    Get.find<FeedController>().onTapInteractingActionButton(type);
  }
}
