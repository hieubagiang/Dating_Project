import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/common/utils/styles.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/presentation/pages/profile/profile_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:dating_app/app/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

import '../premium/premium_controller.dart';

class ProfileScreen extends BaseView<ProfileController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      body: Column(
        children: [
          getBody(context),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!(controller.currentUser.value?.isPremiumUser ?? false))
                  GestureDetector(
                      onTap: () =>
                          Get.find<PremiumController>().showDialogPremium(),
                      child: Row(children: [
                        Expanded(
                            child: Column(children: [
                          Icon(Icons.favorite,
                              size: 100.sp,
                              color: Color.fromRGBO(227, 164, 65, 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.w),
                            child: Text(
                                'click here to upgrade to premium, first experience, save up to 20%'
                                    .tr,
                                overflow: TextOverflow.visible,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily:
                                        'assets/fonts/sf-ui-display-black.ttf',
                                    color: Colors.black.withOpacity(0.8),
                                    fontSize: 18.sp)),
                          )
                        ]))
                      ])),
                SizedBox(height: SpaceUtils.spaceMedium),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: SpaceUtils.spaceSmaller,
                      horizontal: SpaceUtils.spaceSmall),
                  child: ButtonWidget(
                    label: 'signOut'.tr,
                    onPress: () async {
                      Get.find<MainController>().signOut();
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget getBody(context) {
    var size = MediaQuery.of(context).size;
    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        width: size.width,
        height: size.height * 0.60,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 10,
            blurRadius: 10,
            // changes position of shadow
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Center(
                child: Obx(() {
                  return Container(
                    height: 160.h,
                    width: 160.h,
                    child: CustomAvatar(
                        avatarUrl: controller.currentUser.value?.avatarUrl,
                        borderColor: ColorUtils.primaryColor,
                        padding: 1.w,
                        showCameraIcon: true,
                        onTap: controller.addAvatar),
                  );
                }),
              ),
              Padding(
                padding: EdgeInsets.only(top: SpaceUtils.spaceMedium),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Obx(() {
                    return Text('${controller.currentUser.value?.name}, 21'.tr,
                        style: StyleUtils.style20Bold);
                  })
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteList.setting),
                    child: Column(
                      children: [
                        Container(
                          width: 70.sp,
                          height: 70.sp,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Icon(
                            Icons.settings,
                            size: 35.sp,
                            color: ColorUtils.primaryColor2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "setting".tr.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: ColorUtils.primaryColor2,
                          ),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(RouteList.edit),
                    child: Column(
                      children: [
                        Container(
                          width: 70.h,
                          height: 70.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Icon(
                            Icons.edit,
                            size: 35.sp,
                            color: ColorUtils.primaryColor2,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "edit".tr.toUpperCase(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: ColorUtils.primaryColor2),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
