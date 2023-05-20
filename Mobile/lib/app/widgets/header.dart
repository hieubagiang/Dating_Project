import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/feed/controller/feed_controller.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/widgets/bottom_sheet_filter.dart';
import 'package:dating_app/app/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bottomsheet_widget.dart';

class AppbarWidgetCustom extends StatelessWidget {
  final String name;

  AppbarWidgetCustom({Key? key, required this.name}) : super(key: key);

  final controller = Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SpaceUtils.spaceSmall,
        horizontal: SpaceUtils.spaceSmall,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 40.w,
            width: 40.w,
            child: CustomAvatar(
              avatarUrl: controller.currentUser.value?.avatarUrl,
              borderColor: ColorUtils.primaryColor,
              padding: 1.w,
              showCameraIcon: false,
              onTap: () => controller.onChangeTab(3),
            ),
          ),
          Row(
            children: [
              Obx(() {
                if (controller.currentUser.value?.isPremiumUser ?? false) {
                  return Assets.svg.icPremium.svg(width: 30.w, height: 30.w);
                }
                return Assets.images.logo.image(width: 30.w, height: 30.w);
              }),
              const SizedBox(width: 5),
              Text(
                name,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: ColorUtils.primaryColor2,
                  fontFamily: 'assets/fonts/sf-ui-display-black.ttf',
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              await BottomSheetWidget().showBottomSheetComponent(
                context: context,
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'filter'.tr,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w500,
                        color: ColorUtils.primaryColor2,
                      ),
                    ),
                    SizedBox(height: SpaceUtils.spaceMedium),
                    BottomSheetFilter(),
                    SizedBox(height: SpaceUtils.spaceSmall),
                  ],
                ),
              );
              Get.find<FeedController>().getRecommendation();
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Assets.svg.filter.svg(),
            ),
          )
        ],
      ),
    );
  }
}
