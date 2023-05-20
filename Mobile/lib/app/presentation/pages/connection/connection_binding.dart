import 'package:dating_app/app/data/repositories/matches_repository.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/chosen_tab/chosen_tab_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/top_picks_tab/top_picks_tab_controller.dart';
import 'package:get/get.dart';

import 'connection_controller.dart';
import 'widgets/liked_tab/liked_tab_controller.dart';

class MatchesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MatchesRepository());
    Get.lazyPut(() => LikedTabController());
    Get.lazyPut(() => ChosenTabController());
    Get.lazyPut(() => TopPicksTabController());
    Get.lazyPut(() => MatchesController());
  }
}
