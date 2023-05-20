import 'package:collection/collection.dart';
import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:money2/money2.dart';

import '../../../data/models/subscription_package_model/subscription_package_model.dart';

class PremiumDialog extends StatefulWidget {
  final List<SubscriptionPackageModel> subscriptionPackages;

  const PremiumDialog({
    Key? key,
    required this.subscriptionPackages,
  }) : super(key: key);

  @override
  State<PremiumDialog> createState() => _PremiumDialogState();
}

class _PremiumDialogState extends State<PremiumDialog> {
  int indexChoose = 1;
  Currency vndCurrency = Currency.create('VND', 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      //this right here
      child: Container(
        height: Get.height * 0.75,
        width: Get.width * 0.95,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15.h),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'upgrade-to-a-premium-account'.tr,
                overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorUtils.premiumColor,
                  fontSize: 22.sp,
                ),
              ),
            ),
            Icon(Icons.favorite, size: 100.sp, color: ColorUtils.premiumColor),
            Text(
              'see-liked-u'.tr,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'assets/fonts/sf-ui-display-black.ttf',
                color: Colors.black.withOpacity(0.8),
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'see-liked-u&match'.tr,
              overflow: TextOverflow.visible,
              style: TextStyle(
                fontFamily: 'assets/fonts/sf-ui-display-black.ttf',
                color: Colors.black.withOpacity(0.8),
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: 15.h),
            Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 10.h),
                    Container(
                      color: Colors.black.withOpacity(0.1),
                      height: 120.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: widget.subscriptionPackages.mapIndexed(
                          (index, e) {
                            final isSelected = index == indexChoose;
                            final model = widget.subscriptionPackages[index];
                            return Expanded(
                              child: InkWell(
                                onTap: () => setState(() {
                                  indexChoose = index;
                                }),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: isSelected
                                      ? BoxDecoration(
                                          border: Border.all(
                                            color: ColorUtils.premiumColor,
                                            width: 2,
                                          ),
                                        )
                                      : null,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: 10.h),
                                      Text(
                                        model.name ?? '',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp,
                                          color: isSelected
                                              ? ColorUtils.premiumColor
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        Money.fromIntWithCurrency(
                                          model.price ?? 0,
                                          vndCurrency,
                                        ).format('###,###,### CCC'),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16.sp,
                                          color: isSelected
                                              ? ColorUtils.premiumColor
                                              : Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ).toList(),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 2.h, horizontal: 10.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.r)),
                      color: ColorUtils.premiumColor,
                    ),
                    child: Text(
                      'popular'.tr,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: SpaceUtils.spaceSmaller,
                horizontal: SpaceUtils.spaceSmall,
              ),
              child: ButtonWidget(
                color: ColorUtils.premiumColor,
                label: 'continue'.tr,
                onPress: () {
                  Get.back();
                  Get.toNamed(
                    RouteList.paymentScreen,
                    arguments: widget.subscriptionPackages[indexChoose],
                  );
                },
              ),
            ),
            Column(
              children: [
                Text(
                  'note-premium1'.tr,
                  style:
                      TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Text('note-premium2'.tr, textAlign: TextAlign.center),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
