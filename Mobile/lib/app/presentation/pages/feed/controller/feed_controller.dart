import 'dart:convert';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/configs/configurations.dart';
import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:dating_app/app/common/helper/ad_helper.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/args/user_profile_args.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/models/pagination.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/feed_repository.dart';
import 'package:dating_app/app/data/repositories/message_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

import 'boost_controller_mixin.dart';

class FeedController extends BaseController with BoostController {
  Rx<InteractType?> interactType = Rx(null);
  RxInt selectedIndex = 0.obs;
  RxInt currentIndex = 0.obs;
  PageController? pageController;
  final cardController = SwipableStackController();
  FeedRepository _repository = Get.find<FeedRepository>();
  RxList<UserModel> userList = <UserModel>[].obs;
  Rx<BaseStateStatus> dataState = Rx(BaseStateStatus.init);
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  Rx<ScrollPhysics> physics = Rx(const BouncingScrollPhysics());
  RxString heroTag = ''.obs;
  final adHelper = AdHelper();
  bool isGuestMode = Get.find<MainController>().isGuestMode;
  final ChatRepository chatRepository = Get.find<ChatRepositoryImpl>();
  final messageTextController = TextEditingController();
  Rx<ChannelModel> channel = Rx(ChannelModel());
  UserModel? currentModel;
  final demoUser = UserModel.fromJson(jsonDecode(
      '{"id":"8aGoAQ1n4LVUdr59YqgQoZOZOLo2","name":"Hải My","email":"demo1@gmail.com","username":"demo1","gender":"female","birthday":"2000-07-07T00:00:00.000","avatar_url":"https://firebasestorage.googleapis.com/v0/b/tinder-clone-36718.appspot.com/o/photos%2F8aGoAQ1n4LVUdr59YqgQoZOZOLo2%2Favatar.jpg?alt=media&token=f6c9b4ac-10f4-4555-be2b-7a98ac1411e9","photo_list":[],"description":"demo1","hobbies":[],"premium_expire_at":"2022-07-20T21:55:46.234474","location":{"latitude":37.4219983,"longitude":-122.084,"address":"Phùng Khoang, Việt Nam","update_at":"2022-07-14T15:19:14.210927"},"feed_filter":{"distance":100.0,"interested_in_gender":2,"age_range":{"start":16,"end":40},"update_at":"2022-07-14T15:19:14.211142"},"online_flag":true,"update_at":"2022-07-14T15:19:14.211599"}'));
  Rx<Pagination> pagination = Pagination(limit: 10).obs;
  @override
  Future<void> onInit() async {
    withScrollController = true;

    ///Pagination userList
    currentIndex.stream.listen((currentIndex) async {
      if (!(currentUser.value?.isPremiumUser ?? false) &&
          currentIndex % Configurations.adsCount == 0) {
        if (isGuestMode) return;
        adHelper.createInterstitialAd();
      }
      if (currentIndex == userList.length - 1) {
        await getRecommendation(isLoadMore: true);
      } else if (currentIndex == userList.length) {
        // check is lastPage
      }
    });
    if (!isGuestMode) {
      initBoostController();
    }
    super.onInit();
  }

  @override
  void onReady() async {
    scrollController.addListener(() {
      physics.value =
          (!scrollController.hasClients || scrollController.offset < 0)
              ? const NeverScrollableScrollPhysics()
              : const BouncingScrollPhysics();
      if (scrollController.offset > scrollController.position.maxScrollExtent) {
        Get.toNamed(RouteList.userProfile,
            arguments: UserProfileArgs(
                model: userList[currentIndex.value], heroTag: heroTag.value));
      }
    });
    currentUser.stream.first.then((value) async {
      if (value != null) {
        await getRecommendation();
      }
    });
    if (isGuestMode) {
      await getRecommendation();
    }
    FunctionUtils.logWhenDebug(this, "$userList");
    dataState.stream.listen((state) {
      if (state != BaseStateStatus.success) {
        commonController.startLoading();
      } else {
        commonController.stopLoading();
      }
    });
    commonController.stopLoading();
  }

  Future<void> onSwipeCompleted(int index, SwipeDirection direction) async {
    if (selectedIndex.value >= userList.length) {
      return;
    }
    if (direction == SwipeDirection.right || direction == SwipeDirection.left) {
      selectedIndex.value = index;
      currentIndex.value++;

      if (!isGuestMode) {
        FunctionUtils.logWhenDebug(this, '$direction');
        interactType.value ??= (direction == SwipeDirection.left)
            ? InteractType.dislike
            : InteractType.like;

        var interactModel = InteractedUserModel(
            currentUser: currentUser.value!.toMatchedUserModel(),
            interactedUser: userList[selectedIndex.value].toMatchedUserModel(),
            interactedType: interactType.value!.id,
            updateAt: DateTime.now(),
            currentUserId: currentUser.value!.id!,
            interactedUserId: userList[selectedIndex.value].id!);
        await _repository.interactUser(interactedUserModel: interactModel);
        interactType.value = null;
      }
    }
  }

  Future<void> undo() async {
    final mainController = Get.find<MainController>();
    if (isGuestMode) {
      mainController.logOutGuest();
      return;
    }
    bool isPremiumUser =
        Get.find<MainController>().currentUser.value?.isPremiumUser ?? false;

    if (!isPremiumUser) {
      Get.dialog(const AdsPremiumDialog());
      return;
    }

    if (cardController.canRewind) {
      cardController.rewind();
      currentIndex.value--;

      var interactModel = InteractedUserModel(
          currentUser: currentUser.value!.toMatchedUserModel(),
          interactedUser: userList[selectedIndex.value].toMatchedUserModel(),
          interactedType: InteractType.undo.id,
          currentUserId: currentUser.value!.id!,
          interactedUserId: userList[selectedIndex.value].id!,
          updateAt: DateTime.now());
      _repository.interactUser(interactedUserModel: interactModel);
      FunctionUtils.logWhenDebug(
          this, 'undo ${userList[selectedIndex.value].name}');
    }
  }

  Future<void> onTapInteractingActionButton(InteractType type) async {
    if (selectedIndex < userList.length) {
      interactType.value = type;
      cardController.next(swipeDirection: SwipeDirection.right);
    }
  }

  Future<void> getRecommendation({bool isLoadMore = false}) async {
    if (!isLoadMore) {
      pagination.value = Pagination().first();
      commonController.startLoading();
    } else {
      pagination.value = pagination.value.next();
    }
    if (pagination.value.isLastPage) {
      return;
    }
    try {
      var tmp = await _repository.getRecommendation(
        pagination: pagination.value,
      );
      if (tmp?.data == null) {
        commonController.showDialogMessage(message: 'something_went_wrong'.tr);
        return;
      }
      List<UserModel> res = tmp?.data?.toList() ?? [];
      pagination.value = tmp?.pagination ?? pagination.value;
      // res.shuffle();
      if (!isLoadMore) {
        userList.clear();
        userList.add(demoUser);
        userList.add(demoUser);
      } else {}
      userList.addAll(res);
      dataState.value = BaseStateStatus.success;
    } on Exception catch (e) {
      FunctionUtils.logWhenDebug(this, e.toString());
      commonController.stopLoading();
      dataState.value = BaseStateStatus.error;
    }
  }

  bool get isOverList => currentIndex.value >= userList.length;

  Future<void> sendFirstMessage() async {
    final channelModel = await chatRepository.createChannel(
        currentUserId: currentUser.value?.id ?? '',
        selectedUserId: userList[currentIndex.value].id ?? '');

    var now = DateTime.now();
    final message = MessageModel(
        messageId: now.millisecondsSinceEpoch.toString(),
        senderId: currentUser.value?.id,
        senderName: currentUser.value?.name,
        avatarUrl: currentUser.value?.avatarUrl,
        text: messageTextController.text,
        createAt: now);
    await chatRepository.sendMessage(
        channelId: channelModel.channelId ?? '', message: message);
    messageTextController.clear();

    //update unreadCount
    var updatedMemberModel = channel.value.members
        ?.map((e) => e.id == currentUser.value?.id
            ? e
            : e.copyWith(unreadCount: e.unreadCount + 1))
        .toList();
    await chatRepository.updateChannel(
        channelId: channelModel.channelId ?? '',
        channelModel: channel.value.copyWith(members: updatedMemberModel));
  }
}
