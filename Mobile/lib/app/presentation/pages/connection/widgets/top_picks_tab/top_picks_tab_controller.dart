import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/models/args/user_profile_args.dart';
import 'package:dating_app/app/data/repositories/boost_repository.dart';
import 'package:dating_app/app/data/repositories/feed_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';

import '../../../../../data/enums/interact_type.dart';
import '../../../../../data/models/interaction/interacted_user.dart';

class TopPicksTabController extends BaseController {
  final _repository = Get.find<BoostRepositoryImpl>();
  Rx<List<UserModel>> topPickUserList = Rx([]);
  final _userRepository = Get.find<UserRepository>();
  final commonController = Get.find<CommonController>();

  @override
  void onInit() {
    super.onInit();
    topPickUserList.bindStream(_repository.listenToTopPickListRealTime());
  }

  Future<void> onTapCard(UserModel model, String heroTag) async {
    // commonController.startLoading();
    var userModel = await _userRepository.getUser(userId: model.id);
    Get.toNamed(RouteList.userProfile,
        arguments: UserProfileArgs(model: userModel!, heroTag: heroTag));
    // commonController.stopLoading();
  }

  void interact(UserModel model, InteractType interactedType) {
    final currentUser = Get.find<MainController>().currentUser.value;
    var newModel = InteractedUserModel(
      currentUser: currentUser!.toMatchedUserModel(),
      interactedUser: model.toMatchedUserModel(),
      interactedType: interactedType.id,
      updateAt: DateTime.now(),
      currentUserId: currentUser.id ?? 'error',
      interactedUserId: model.id ?? 'error',
    );
    Get.find<FeedRepository>().interactUser(interactedUserModel: newModel);
  }
}
