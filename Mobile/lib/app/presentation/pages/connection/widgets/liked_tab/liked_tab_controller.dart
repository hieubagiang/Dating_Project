import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/models/args/user_profile_args.dart';
import 'package:dating_app/app/data/repositories/feed_repository.dart';
import 'package:dating_app/app/data/repositories/matches_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';

class LikedTabController extends BaseController {
  final _repository = Get.find<MatchesRepository>();
  Rx<List<InteractedUserModel>> likedUserList = Rx([]);
  final _feedRepository = Get.find<FeedRepository>();
  final _userRepository = Get.find<UserRepository>();
  final commonController = Get.find<CommonController>();

  @override
  void onInit() {
    isEnableLoadMore = true;
    withScrollController = true;
    super.onInit();
    likedUserList.bindStream(_repository.listenToLikedListRealTime());

    isLoadMore.stream.listen((isLoadMore) {
      if (isLoadMore) {
        commonController.startLoading();
      } else {
        commonController.stopLoading();
      }
    });
  }

  void dislike(InteractedUserModel model) {
    _feedRepository.interactUser(
        interactedUserModel: model.copyWith(
            interactedType: InteractType.dislike.id, updateAt: DateTime.now()));
  }

  Future<void> onTapCard(InteractedUserModel model, String heroTag) async {
    var userModel =
        await _userRepository.getUser(userId: model.interactedUserId);
    Get.toNamed(RouteList.userProfile,
        arguments: UserProfileArgs(model: userModel!, heroTag: heroTag));
  }

  @override
  void onLoadMore() {
    _repository.requestMoreLikedData();
    super.onLoadMore();
  }
}
