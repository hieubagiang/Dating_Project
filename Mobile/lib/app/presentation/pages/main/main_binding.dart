import 'package:dating_app/app/data/repositories/message_repository.dart';
import 'package:dating_app/app/presentation/pages/call_module/call_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/chosen_tab/chosen_tab_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/liked_tab/liked_tab_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/top_picks_tab/top_picks_tab_controller.dart';
import 'package:dating_app/app/presentation/pages/feed/controller/feed_controller.dart';
import 'package:dating_app/app/presentation/pages/message/message_list/message_list_controller.dart';
import 'package:dating_app/app/presentation/pages/profile/profile_controller.dart';
import 'package:dating_app/app/presentation/pages/settings/setting_controller.dart';
import 'package:get/get.dart';

import '../premium/premium_controller.dart';
import 'main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => FeedController(),
    );

    Get.lazyPut(
      () => LikedTabController(),
    );
    Get.lazyPut(
      () => ChosenTabController(),
    );
    Get.lazyPut(
      () => TopPicksTabController(),
    );
    Get.lazyPut(() => MatchesController());
    Get.lazyPut(() => ChatRepositoryImpl());
    Get.lazyPut(() => MessageListController());
    Get.lazyPut(() => SettingsController());
    Get.lazyPut(() => ProfileController());
    Get.put(CallController());
    Get.put(MainController());
    Get.put(PremiumController());

    // Get.lazyPut(() => DetailMessageController());
  }
}
