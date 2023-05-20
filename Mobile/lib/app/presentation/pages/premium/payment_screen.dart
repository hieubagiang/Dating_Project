import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/common/utils/styles.dart';
import 'package:dating_app/app/data/enums/subscription_enum.dart';
import 'package:dating_app/app/presentation/pages/premium/premium_controller.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

import '../main/main_controller.dart';

class PaymentScreen extends BaseView<PremiumController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: ColorUtils.primaryColor2)),
        backgroundColor: ColorUtils.whiteColor,
        title: Text('payment'.tr, style: StyleUtils.style24Medium),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceMedium),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, bottom: 15),
                child: Text('payment-by-momo'.tr,
                    style: TextStyle(
                        fontSize: 18.sp, fontWeight: FontWeight.w600)),
              ),
              Image.network(
                  'https://images.viblo.asia/5974cb6b-ec70-41d0-9074-d4319b62f4c7.png'),
              SizedBox(height: SpaceUtils.spaceMedium),
              Text('Sử dụng app Momo hoặc ứng dụng hỗ trợ',
                  style: StyleUtils.style20Normal),
              Text('QR code để quét mã', style: StyleUtils.style20Normal),
              SizedBox(height: SpaceUtils.spaceMedium),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Tài khoản nhận tiền',
                            style: StyleUtils.style24Medium),
                        Text('0941 716 670', style: StyleUtils.style20Normal),
                        Text('PHAM DOAN HIEU', style: StyleUtils.style20Normal),
                        SizedBox(height: SpaceUtils.spaceMedium),
                        Text('Số tiền cần chuyển',
                            style: StyleUtils.style24Medium),
                        Text(
                            SubscriptionType
                                .values[controller.indexChoose.value].cost,
                            style: StyleUtils.style20Bold),
                        SizedBox(height: SpaceUtils.spaceMedium),
                        Text('Nội dung chuyển tiền',
                            style: StyleUtils.style24Medium),
                        Text(
                            '${Get.find<MainController>().currentUser.value?.username}',
                            style: StyleUtils.style20Normal),
                        SizedBox(height: SpaceUtils.spaceSmall),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: Get.width / 2,
                              child: ButtonWidget(
                                label: 'Mở Momo',
                                onPress: () async {
                                  await LaunchApp.openApp(
                                      androidPackageName:
                                          'com.mservice.momotransfer',
                                      openStore: false);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
