import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../premium_controller.dart';

class PremiumInit extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SpaceUtils.spaceLarge),
            Text('premium'.tr,
                style: TextStyle(
                    color: ColorUtils.premiumColor,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800)),
            SizedBox(height: 10),
            Divider(
              color: ColorUtils.premiumColor,
            ),
            SizedBox(height: 30),
            Text(
              'get-33%'.tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
            ),
            Text(
              'first-month'.tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32.sp),
            ),
            SizedBox(height: 50),
            Text('today'.tr,
                style: TextStyle(
                    color: ColorUtils.premiumColor,
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic)),
            SizedBox(height: 20),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'was'.tr,
                style: TextStyle(color: Colors.grey, fontSize: 24.sp),
              ),
              TextSpan(
                text: '15,000đ',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 24.sp,
                  decoration: TextDecoration.lineThrough,
                ),
              )
            ])),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: 'now'.tr,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8), fontSize: 24.sp),
              ),
              TextSpan(
                text: '10,000đ',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 24.sp,
                ),
              )
            ])),
            SizedBox(height: 50),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Icon(Icons.check,
                        size: 32.sp, color: ColorUtils.premiumColor),
                    SizedBox(width: 15),
                    Text(
                      'unlimited-like'.tr,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Icon(Icons.check,
                        size: 32.sp, color: ColorUtils.premiumColor),
                    SizedBox(width: 15),
                    Text(
                      'see-liked-u'.tr,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Icon(Icons.check,
                        size: 32.sp, color: ColorUtils.premiumColor),
                    SizedBox(width: 15),
                    Text(
                      'boost-profile'.tr,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Icon(Icons.check,
                        size: 32.sp, color: ColorUtils.premiumColor),
                    SizedBox(width: 15),
                    Text(
                      'send-super-like'.tr,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    )
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Row(children: [
                    Icon(Icons.check,
                        size: 32.sp, color: ColorUtils.premiumColor),
                    SizedBox(width: 15),
                    Text(
                      'ad-blocking'.tr,
                      style: TextStyle(
                          fontSize: 22.sp, fontWeight: FontWeight.w500),
                    )
                  ]),
                ),
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ButtonWidget(
                    label: 'continue'.tr,
                    height: 50.h,
                    color: ColorUtils.premiumColor,
                    labelColor: ColorUtils.whiteColor,
                    onPress: () =>
                        Get.find<PremiumController>().showDialogPremium()),
                ButtonWidget(
                  label: 'later'.tr,
                  height: 50.h,
                  labelColor: ColorUtils.blackColor.withOpacity(0.5),
                  color: ColorUtils.whiteColor,
                  onPress: () => Get.offAllNamed(RouteList.main),
                ),
                SizedBox(height: SpaceUtils.spaceSmall)
              ],
            ))
          ],
        ),
      ),
    );
  }
}
