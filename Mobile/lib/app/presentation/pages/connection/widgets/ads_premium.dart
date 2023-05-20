import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/common/utils/styles.dart';
import 'package:dating_app/app/data/enums/ads_premium_enum.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../premium/premium_controller.dart';

class AdsPremium extends StatelessWidget {
  final AdsPremiumType type;

  const AdsPremium({Key? key, required this.type}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: SpaceUtils.spaceMedium),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('upgrade-to-premium'.tr + ':',
                        style: StyleUtils.style20Normal
                            .copyWith(color: ColorUtils.primaryColor)),
                  ],
                ),
                SizedBox(height: SpaceUtils.spaceMedium),
                _buildFeatureText(
                    '- Đưa trang cá nhân lên top lựa chọn, tiếp cận nhiều người hơn'),
                _buildFeatureText('- Bỏ lỡ một người, đừng lo đã có quay lại'),
                _buildFeatureText('- Mở khoá giới hạn tương tác mỗi ngày'),
                _buildFeatureText('- Nhắn tin ngay cả khi chưa tương hợp'),
                _buildFeatureText(
                    '- Xem ai đã thích bạn, bạn đã tương tác với ai'),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.volunteer_activism,
                          size: 100.sp, color: Color.fromRGBO(227, 164, 65, 1)),
                      SizedBox(height: SpaceUtils.spaceSmall),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('easy-payment'.tr,
                            style: StyleUtils.style20Normal,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: SpaceUtils.spaceSmaller,
                horizontal: SpaceUtils.spaceLarge),
            child: ButtonWidget(
                color: Color.fromRGBO(227, 164, 65, 1),
                label: 'subscription-now'.tr,
                onPress: () =>
                    Get.find<PremiumController>().showDialogPremium()),
          )
        ]);
  }

  Widget _buildFeatureText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceMedium),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(text,
                textAlign: TextAlign.left,
                style: StyleUtils.style16Italic.copyWith(fontSize: 20.sp)),
          ),
        ],
      ),
    );
  }
}
