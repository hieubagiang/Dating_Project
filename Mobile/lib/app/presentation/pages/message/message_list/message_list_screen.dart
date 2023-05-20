import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:dating_app/app/widgets/empty_data_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/header.dart';
import 'message_list_controller.dart';

class MessageListScreen extends BaseView<MessageListController> {
  final MainController mainController = Get.find<MainController>();

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Obx(() {
            return Column(
              children: [
                AppbarWidgetCustom(name: 'chat'.tr),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          cursorColor: Colors.black,
                          controller: controller.searchController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.search,
                              color: ColorUtils.primaryColor2,
                            ),
                            hintText: "search".tr,
                            border: InputBorder.none,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorUtils.blackColor.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorUtils.blackColor.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                      ),
                      controller.isSearching.isTrue
                          ? _buildSearchedResult(context)
                          : _buildChatList(context)
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Column _buildChatList(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (controller.matchedList.isEmpty && controller.channelList.isEmpty)
          Column(
            children: [
              Image.asset(
                'assets/images/photos.png',
                height: Get.height / 1.8,
              ),
              Text(
                'new-friend'.tr,
                style: StyleUtils.style20Normal,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: SpaceUtils.spaceMedium),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ButtonWidget(
                    label: 'start-chat'.tr,
                    height: 50.h,
                    color: ColorUtils.premiumColor,
                    labelColor: ColorUtils.whiteColor,
                    onPress: () => mainController.onChangeTab(0),
                  ),
                  SizedBox(height: SpaceUtils.spaceSmall)
                ],
              )
            ],
          ),
        Obx(() {
          return (controller.matchedList.isNotEmpty)
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 15.h),
                  child: Text('new_match'.tr, style: StyleUtils.style24Medium),
                )
              : const SizedBox();
        }),
        _newMatchList(),
        SizedBox(
          height: 30.h,
        ),
        Column(
          children: [
            ///TODO handle it
            // _superLikeItem(context),
            Obx(() {
              if (controller.channelList.isEmpty) return Container();

              return Column(
                children: [
                  ...List.generate(controller.channelList.length, (index) {
                    var model = controller.channelList[index];
                    return InkWell(
                      onTap: () {
                        controller.onTapChannel(model.channelId!);
                      },
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: 60.w,
                              height: 60.w,
                              child: Stack(
                                children: <Widget>[
                                  Container(
                                    width: 60.w,
                                    height: 60.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          controller
                                                  .getSelectedUser(index)
                                                  .avatarUrl ??
                                              '',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      width: 15.w,
                                      height: 15.w,
                                      decoration: BoxDecoration(
                                        color: ColorUtils.activeColor,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 3,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  controller.getSelectedUser(index).name ?? '',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: 5.h,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 135.w,
                                  child: _buildLastMessage(model),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ],
              );
            }),
          ],
        )
      ],
    );
  }

  Text _buildLastMessage(ChannelModel model) {
    final currentUserId = controller.currentUser.value?.id;
    return Text(
      model.lastMessage?.getLastMessage(currentUserId: currentUserId) ?? '',
      style: TextStyle(fontSize: 15.sp, color: Colors.black.withOpacity(0.8)),
      overflow: TextOverflow.ellipsis,
    );
  }

  //TODO handle supper like
/*
  InkWell _superLikeItem(BuildContext context) {
    return InkWell(
      onTap: () => print('nang cap premium!!'),
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: Padding(
                    padding: EdgeInsets.all(3.0),
                    child: Container(
                      width: 60.w,
                      height: 60.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(
                                  FakeData().userMessages[6]['img']),
                              fit: BoxFit.cover)),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    Text(
                      'Ngọc Trinh',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(width: 10),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(3)),
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text('Super Like',
                            style: TextStyle(
                                color: ColorUtils.whiteColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 135,
                  child: Text(
                    'send_superlike'.tr,
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.8)),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }*/

  SingleChildScrollView _newMatchList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Obx(() {
            return Row(
              children: List.generate(controller.matchedList.length, (index) {
                var model = controller.matchedList[index];
                return Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: 70.w,
                        height: 100.h,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              width: 70.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: NetworkImage(model.avatarUrl),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            ///TODO handle online
                            /*FakeData().userStories[index]['online']
                                  ? Positioned(
                                right: 0,
                                child: Container(
                                  width: 20.w,
                                  height: 20.w,
                                  decoration: BoxDecoration(
                                      color: ColorUtils.activeColor,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: Colors.white, width: 3)),
                                ),
                              )
                                  : Container()*/
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: 75.w,
                        child: Align(
                          child: Text(
                            model.name,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      )
                    ],
                  ),
                );
              }),
            );
          })
        ],
      ),
    );
  }

  Widget _buildSearchedResult(context) {
    return Padding(
      padding: EdgeInsets.only(
        left: SpaceUtils.spaceSmaller,
        top: SpaceUtils.spaceMedium,
      ),
      child: (controller.dataState.value == BaseStateStatus.loading)
          ? UnconstrainedBox(
              child: SizedBox(
                height: SpaceUtils.spaceLarge,
                width: SpaceUtils.spaceLarge,
                child: CupertinoActivityIndicator(
                  color: ColorUtils.primaryColor,
                ),
              ),
            )
          : (controller.dataState.value == BaseStateStatus.success)
              ? controller.searchedList.isEmpty
                  ? EmptyDataWidget()
                  : Column(
                      children: List.generate(controller.searchedList.length,
                          (index) {
                        var model = controller.searchedList[index];
                        return InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            controller.onTapChannel(model.channelId!);
                            controller.searchController.clear();
                          },
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: SpaceUtils.spaceMedium),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 60.w,
                                  height: 60.w,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        width: 60.w,
                                        height: 60.w,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              controller
                                                      .getSelectedUser(index)
                                                      .avatarUrl ??
                                                  '',
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 15.w,
                                          height: 15.w,
                                          decoration: BoxDecoration(
                                            color: ColorUtils.activeColor,
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: Colors.white,
                                              width: 3,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      controller.getSelectedUser(index).name ??
                                          '',
                                      style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().screenWidth - 135.w,
                                      child: Text(
                                        '${model.lastMessage?.senderId == controller.currentUser.value?.id ? 'Bạn: ' : ''}'
                                        '${model.lastMessage?.getMessage()} - ${DateTimeUtils.getStringTimeAgo(model.lastMessage?.updateAt, Pattern.ddMMyyyy)}',
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                          color: Colors.black.withOpacity(0.8),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                    )
              : SizedBox(),
    );
  }
}
