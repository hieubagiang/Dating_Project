import 'dart:math';

import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/widgets/email_input_form.dart';
import 'package:dating_app/app/presentation/pages/feed/widgets/card_label.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/profile_card.dart';
import 'package:dating_app/app/presentation/widgets/user_profile_common.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:dating_app/app/widgets/empty_data_widget.dart';
import 'package:dating_app/app/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
// ignore: implementation_imports
import 'package:swipable_stack/src/model/swipe_properties.dart';
import 'package:swipable_stack/swipable_stack.dart';

import '../../../data/models/args/user_profile_args.dart';
import '../main/main_controller.dart';
import '../premium/premium_controller.dart';
import 'const_data.dart';
import 'controller/feed_controller.dart';

class FeedScreen extends StatelessWidget with userProfileCommon {
  final controller = Get.find<FeedController>();

  Padding _buildInteractingActionBar() {
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SpaceUtils.spaceSmall, 8, SpaceUtils.spaceSmall, 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: bottomIconDataList.map((e) {
          return bottomButtonWidget(
              data: e,
              dislike: () {
                controller.cardController.next(
                  swipeDirection: SwipeDirection.left,
                );
              },
              like: () {
                controller.cardController.next(
                  swipeDirection: SwipeDirection.right,
                );
              },
              superLike: _showTestDialog,
              undo: controller.undo,
              boost: controller.boost);
        }).toList(),
      ),
    );
  }

  void _showTestDialog() {
    if (MainController.isDemoMode) {
      FunctionUtils.showToast('coming_soon'.tr);
      return;
    }
    final mainController = Get.find<MainController>();
    final bool isGuestMode = mainController.isGuestMode;
    if (isGuestMode) {
      mainController.logOutGuest();
      return;
    }
    Get.dialog((controller.currentUser.value?.isPremiumUser ?? false)
        ? AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(
                child: Text("send_message_now".tr,
                    style: TextStyle(color: ColorUtils.primaryColor2))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              height: Get.height * 0.2,
              width: Get.width * 0.8,
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Text('easy-access-partner'.tr,
                      textAlign: TextAlign.center,
                      style: StyleUtils.style16Normal),
                  SizedBox(height: 10),
                  BaseInputForm(
                    textController: controller.messageTextController,
                    backgroundColor: Colors.black.withOpacity(0.1),
                  )
                  // Container(
                  //   height: 35.h,
                  //   child: SingleChildScrollView(
                  //     scrollDirection: Axis.horizontal,
                  //     child: Row(
                  //       crossAxisAlignment: CrossAxisAlignment.stretch,
                  //       children: [
                  //         _buildMessage('Hi!'),
                  //         SizedBox(width: 15),
                  //         _buildMessage('eaten'.tr),
                  //         SizedBox(width: 15),
                  //         _buildMessage('let-make-friend'.tr),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await controller.sendFirstMessage();
                      Get.back();
                      FunctionUtils.showSnackBar(
                          'Thông báo', 'Đã gửi tin nhắn thành công!',
                          colorText: ColorUtils.primaryColor2);
                      controller.messageTextController.text = '';
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                      decoration: BoxDecoration(
                          color: ColorUtils.primaryColor2,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'send'.tr,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                      controller.messageTextController.text = '';
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        'cancel'.tr,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        : AlertDialog(
            contentPadding: EdgeInsets.only(left: 25, right: 25),
            title: Center(
                child: Text("upgrade_to_premium".tr,
                    style: TextStyle(color: ColorUtils.primaryColor2))),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            content: Container(
              width: Get.width * 0.8,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 15),
                  Text('des_first_message'.tr,
                      textAlign: TextAlign.center,
                      style: StyleUtils.style16Normal),
                  SizedBox(height: 10),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ButtonWidget(
                          label: 'upgrade'.tr,
                          height: 50.h,
                          color: ColorUtils.premiumColor,
                          labelColor: ColorUtils.whiteColor,
                          onPress: () => Get.find<PremiumController>()
                              .showDialogPremium()),
                      SizedBox(
                        height: SpaceUtils.spaceSmall,
                      ),
                      ButtonWidget(
                        label: 'later'.tr,
                        height: 50.h,
                        labelColor: ColorUtils.blackColor.withOpacity(0.5),
                        color: ColorUtils.whiteColor,
                        onPress: () => Get.back(),
                      ),
                      SizedBox(height: SpaceUtils.spaceSmall)
                    ],
                  )
                ],
              ),
            ),
            actions: <Widget>[],
          ));
  }

  Widget _overlayBuilder(
      BuildContext context, OverlaySwipeProperties properties) {
    final opacity = min(properties.swipeProgress, 1.0);
    final isRight = properties.direction == SwipeDirection.right;
    final isLeft = properties.direction == SwipeDirection.left;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isRight)
          Opacity(
            opacity: isRight ? opacity : 0,
            child: CardLabel.right(),
          ),
        if (isLeft)
          Opacity(
            opacity: isLeft ? opacity : 0,
            child: CardLabel.left(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        AppbarWidgetCustom(name: 'discovery'.tr),
        Expanded(
          child: Obx(() => Stack(
                children: [
                  ...[
                    _bodyWidget(context),
                  ],
                  if (controller.dataState.value == BaseStateStatus.success &&
                      (controller.isOverList || controller.isOverList))
                    Center(child: EmptyDataWidget())
                ],
              )),
        ),
      ],
    ));
  }

  Column _bodyWidget(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GetBuilder<FeedController>(
            assignId: true,
            init: controller,
            autoRemove: false,
            builder: (controller) {
              if (controller.dataState.value == BaseStateStatus.init) {
                // skeleton container
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: SpaceUtils.spaceMedium,
                    vertical: SpaceUtils.spaceMedium,
                  ),
                  child: SwipableStack(
                    builder: (context, properties) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      );
                    },
                    itemCount: 10,
                    overlayBuilder: _overlayBuilder,
                  ),
                );
              }
              return Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 1.sh,
                    color: Colors.transparent,
                    child: SwipableStack(
                      builder: (context, properties) {
                        var model = controller.userList[properties.index];
                        var heroTag =
                            '${runtimeType}_user_profile_card_${model.id}';
                        return ProfileCard(
                          name: model.name ?? '',
                          age: model.age,
                          heroTag: heroTag,
                          imageUrl: model.avatarUrl,
                          fontSize: 36.sp,
                          ratio: ScreenUtil().screenWidth /
                              ScreenUtil().screenHeight,
                          titleBottomPosition: ScreenUtil().screenHeight / 8,
                          titleLeftPosition: SpaceUtils.spaceMedium,
                          padding: EdgeInsets.symmetric(
                              vertical: SpaceUtils.spaceMedium,
                              horizontal: SpaceUtils.spaceSmall),
                          onTap: () => Get.toNamed(
                            RouteList.userProfile,
                            arguments: UserProfileArgs(
                                model: controller.userList[properties.index],
                                heroTag: heroTag),
                          ),
                          id: model.id ?? '',
                        );
                      },
                      controller: controller.cardController,
                      itemCount: controller.userList.length,
                      allowVerticalSwipe: false,
                      onSwipeCompleted: controller.onSwipeCompleted,
                      overlayBuilder: _overlayBuilder,
                    ),
                  ),
                  Obx(() {
                    return !(controller.currentIndex.value >
                            controller.userList.length)
                        ? _buildInteractingActionBar()
                        : const SizedBox();
                  })
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
