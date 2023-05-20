import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';

import 'welcome_controller.dart';

class WelcomeScreen extends BaseView<WelcomeController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorUtils.greyColor,
        height: ScreenUtil().screenHeight,
        width: ScreenUtil().screenWidth,
        padding: EdgeInsets.symmetric(
            horizontal: SpaceUtils.spaceMedium,
            vertical: SpaceUtils.spaceMedium),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                ImageUtils.welcomeImage,
              ),
            ),
            /*Center(
              child: Text(
                'appName'.tr,
                style: StyleUtils.style16Bold
                    .copyWith(color: ColorUtils.primaryColor, fontSize: 30.sp),
              ),
            ),*/
            SizedBox(
              height: ScreenUtil().screenHeight * 0.1,
            ),
            SizedBox(
              height: SpaceUtils.spaceMedium,
            ),
            Text(
              "lets_get_closer".tr,
              style: StyleUtils.style18Medium,
            ),
            SizedBox(height: SpaceUtils.spaceSmall),
            Text(
              "slogan".tr,
              style: TextStyle(
                  color: ColorUtils.primaryTextColor,
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: SpaceUtils.spaceMoreLarge),
            ButtonWidget(
              height: 50.h,
              onPress: () {
                Get.toNamed(RouteList.signIn);
              },
              label: 'getStartedLabel'.tr,
            ),
            SizedBox(height: SpaceUtils.spaceMedium),
          ],
        ),
      ),
    );
  }
}
