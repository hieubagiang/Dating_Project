import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/index.dart';
import '../premium/premium_controller.dart';
import 'setting_controller.dart';

class SettingsScreen extends BaseView<SettingsController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: ColorUtils.primaryColor2)),
        backgroundColor: ColorUtils.whiteColor,
        title: Text('setting'.tr, style: StyleUtils.style24Medium),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF1F2F4),
          padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceMedium),
          child: Column(
            children: [
              SizedBox(
                height: SpaceUtils.spaceSmall,
              ),

              _buildButton(
                label: 'upgrade_acc_premium'.tr,
                onTap: () {
                  Get.find<PremiumController>().showDialogPremium();
                },
              ),
              SizedBox(
                height: SpaceUtils.spaceSmall,
              ),
              _buildButton(
                  label: 'get_rewards'.tr,
                  height: 50.h,
                  onTap: () {
                    controller.onTapReward();
                  }),
              SizedBox(
                height: SpaceUtils.spaceSmall,
              ),
              // _buildContainerLarge(
              //     title: 'setting_acc'.tr,
              //     body: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
              //       child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              //         Text('phoneNumber'.tr, style: TextStyle(fontSize: 18, color: ColorUtils.blackColor.withOpacity(0.5))),
              //         Row(
              //           children: [
              //             Obx(() {
              //               return Text(controller.currentUser.value?.phoneNumber ?? '',
              //                   textAlign: TextAlign.end, style: TextStyle(fontSize: 18, color: ColorUtils.blackColor.withOpacity(0.5)));
              //             }),
              //             // SizedBox(width: SpaceUtils.spaceSmall),
              //             // Icon(Icons.edit_outlined, size: 18, color: ColorUtils.blackColor.withOpacity(0.5))
              //           ],
              //         ),
              //       ]),
              //     ),
              //     description: 'setting_acc_des'.tr),
              // SizedBox(height: SpaceUtils.spaceMedium),
              _buildContainerLarge(
                  title: 'setting_search'.tr,
                  body: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('location'.tr,
                              style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      ColorUtils.blackColor.withOpacity(0.5))),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  width: SpaceUtils.spaceSmall,
                                ),
                                Expanded(
                                  child: Obx(() {
                                    return Text(controller.address.value,
                                        textAlign: TextAlign.end,
                                        style: StyleUtils.style18Normal
                                            .copyWith(
                                                color: ColorUtils.blackColor
                                                    .withOpacity(0.5)));
                                  }),
                                ),
                                // SizedBox(width: SpaceUtils.spaceSmall),
                                // Icon(Icons.edit_outlined, size: 18, color: ColorUtils.blackColor.withOpacity(0.5))
                              ],
                            ),
                          ),
                        ]),
                  ),
                  description: 'setting_search_des'.tr),
              SizedBox(height: SpaceUtils.spaceMedium),

              Obx(() {
                if (controller.currentUser.value?.isPremiumUser ?? false) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildContainerLarge(
                        title: 'Premium days'.tr,
                        body: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: SpaceUtils.spaceSmall),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Remaining'.tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: ColorUtils.blackColor
                                            .withOpacity(0.5))),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: SpaceUtils.spaceSmall,
                                      ),
                                      Expanded(
                                        child: Obx(() {
                                          return Text(
                                              (controller.currentUser.value
                                                              ?.premiumExpireAt ??
                                                          DateTime.now())
                                                      .difference(
                                                          DateTime.now())
                                                      .inDays
                                                      .toString() +
                                                  'days'.tr,
                                              textAlign: TextAlign.end,
                                              style: StyleUtils.style18Normal
                                                  .copyWith(
                                                      color: ColorUtils
                                                          .blackColor
                                                          .withOpacity(0.5)));
                                        }),
                                      ),
                                      // SizedBox(width: SpaceUtils.spaceSmall),
                                      // Icon(Icons.edit_outlined, size: 18, color: ColorUtils.blackColor.withOpacity(0.5))
                                    ],
                                  ),
                                ),
                              ]),
                        ),
                        description: 'Your account is Premium'.tr,
                        subtitleStyle: StyleUtils.style16Normal
                            .copyWith(color: ColorUtils.primaryColor),
                      ),
                      SizedBox(height: SpaceUtils.spaceMedium),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorUtils.whiteColor,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        child: ListTile(
                          onTap: () {
                            Get.toNamed(RouteList.paymentList);
                          },
                          title: Text('payment_list'.tr,
                              style: StyleUtils.style16Normal),
                          trailing: Icon(Icons.arrow_forward_ios, size: 20.w),
                        ),
                      )
                    ],
                  );
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButton(
      {Function()? onTap, required String label, double? height}) {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onTap,
            child: Container(
                height: height ?? 100.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorUtils.whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.black.withOpacity(0.2)),
                  boxShadow: [
                    ShadowUtils.bottomThinShadow,
                    ShadowUtils.topThinShadow
                  ],
                ),
                child: Text(
                  label,
                  style: TextStyle(
                      color: Color.fromRGBO(227, 164, 65, 1),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,
                )),
          ),
        ),
      ],
    );
  }

  Widget _buildContainerLarge(
      {String? title,
      Widget? body,
      String? description,
      TextStyle? subtitleStyle}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: SpaceUtils.spaceSmall),
                  child: Text(title, style: StyleUtils.style20Bold),
                )
              : Container(),
          _buildContainerSmall(widget: body),
          description != null
              ? Padding(
                  padding: EdgeInsets.only(top: SpaceUtils.spaceSmall),
                  child: Text(
                    description,
                    style: subtitleStyle ?? StyleUtils.style16Normal,
                    overflow: TextOverflow.visible,
                  ))
              : Container()
        ]);
  }

  Widget _buildContainerSmall({Widget? widget}) {
    return Container(
        decoration: BoxDecoration(
          color: ColorUtils.whiteColor,
          borderRadius: BorderRadius.circular(3),
          boxShadow: [ShadowUtils.bottomThinShadow, ShadowUtils.topThinShadow],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SpaceUtils.spaceSmall),
          child: widget,
        ));
  }
}
