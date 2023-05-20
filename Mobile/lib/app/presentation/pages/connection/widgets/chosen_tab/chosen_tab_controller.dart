import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/args/user_profile_args.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/repositories/feed_repository.dart';
import 'package:dating_app/app/data/repositories/matches_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';

class ChosenTabController extends BaseController {
  final _repository = Get.find<MatchesRepository>();
  Rx<List<InteractedUserModel>> chosenUserList = Rx([]);
  final _feedRepository = Get.find<FeedRepository>();
  final _userRepository = Get.find<UserRepository>();
  final commonController = Get.find<CommonController>();

  @override
  void onInit() {
    super.onInit();
    chosenUserList.bindStream(_repository.listenToChosenListRealTime());
    chosenUserList.listen((list) {
      Get.find<MatchesController>().totalChosen.value = list.length;
    });
  }

  Future<void> onTapCard(String userId, String heroTag) async {
    commonController.startLoading();
    var userModel = await _userRepository.getUser(userId: userId);
    Get.toNamed(RouteList.userProfile,
        arguments: UserProfileArgs(model: userModel!, heroTag: heroTag));
    commonController.stopLoading();
  }

  void interact(InteractedUserModel model, InteractType interactedType) {
    var newModel = InteractedUserModel(
      currentUser: model.interactedUser,
      interactedUser: model.currentUser,
      interactedType: interactedType.id,
      updateAt: model.updateAt,
      currentUserId: model.interactedUserId,
      interactedUserId: model.currentUserId,
    );
    _feedRepository.interactUser(interactedUserModel: newModel);
  }
}
