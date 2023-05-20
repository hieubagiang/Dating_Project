import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:flutter/material.dart';

import 'connection_tab_bar_enum.dart';

class MatchesController extends BaseController
    with GetSingleTickerProviderStateMixin {
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  Rx<int?> totalChosen = Rx(null);

  TabController? tabController;
  RxBool isInitDone = false.obs;

  @override
  void onInit() {
    tabController = TabController(
      vsync: this,
      length: MatchTabBarType.values.length,
    );
    super.onInit();
    isInitDone.value = true;
  }
}
