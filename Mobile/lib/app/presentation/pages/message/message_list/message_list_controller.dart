import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/chat/member_model.dart';
import 'package:dating_app/app/data/models/interaction/matched_user_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/matches_repository.dart';
import 'package:dating_app/app/data/repositories/message_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

class MessageListController extends BaseController {
  final ChatRepository chatRepository = Get.find<ChatRepositoryImpl>();
  final MatchesRepository matchesRepository = Get.find<MatchesRepository>();
  TextEditingController searchController = TextEditingController();
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  final debouncer = Debouncer(delay: Duration(milliseconds: 500));
  Rx<BaseStateStatus> dataState = BaseStateStatus.success.obs;
  RxList<ChannelModel> channelList = <ChannelModel>[].obs;
  RxList<MatchedUserModel> matchedList = <MatchedUserModel>[].obs;
  RxList<ChannelModel> searchedList = <ChannelModel>[].obs;
  RxBool isSearching = false.obs;
  @override
  void onInit() {
    chatRepository
        .queryAllChannel(currentID: currentUser.value!.id!)
        .listen((list) {
      channelList.clear();
      channelList.addAll(list);
    });
    matchedList.bindStream(matchesRepository.listenToMatchedListRealTime());
    searchController.addListener(() {
      isSearching.value = searchController.text.isNotEmpty;
      debouncer.call(() async {
        dataState.value = BaseStateStatus.loading;
        searchedList.value = await matchesRepository.queryMatchedList(
            name: searchController.text);
        dataState.value = BaseStateStatus.success;
      });
    });
    searchedList.stream.listen((event) {
      print(event.toString());
    });
    super.onInit();
  }

  MemberModel getSelectedUser(int index) {
    return channelList[index]
        .members!
        .where((element) => element.id != currentUser.value!.id!)
        .first;
  }

  void onTapChannel(String channelId) {
    Get.toNamed(
      RouteList.chatDetailRoute(id: channelId),
    );
  }

//
}
