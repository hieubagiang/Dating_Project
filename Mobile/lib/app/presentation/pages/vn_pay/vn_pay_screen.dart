import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/vnpay_webview/progress_indicator.dart';
import '../../../widgets/vnpay_webview/vnpay_webview.dart';
import 'vn_pay_controller.dart';
import 'widgets/payment_result_card.dart';

class VnPayScreen extends StatefulWidget {
  const VnPayScreen({Key? key}) : super(key: key);

  @override
  State<VnPayScreen> createState() => _VnPayScreenState();
}

class _VnPayScreenState extends State<VnPayScreen> {
  final controller = Get.find<VnPayController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //create appbar container with leading and title,
            Obx(() {
              return Visibility(
                visible: controller.showWebView.isFalse,
                child: AppBar(
                  title: Text(
                    'payment_detail'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            }),
            Expanded(
              child: Obx(
                () {
                  if (controller.createPaymentResponse.value == null) {
                    return const Center(
                      child: InfiniteProgressIndicator(
                        color: ColorUtils.primaryColor,
                      ),
                    );
                  }
                  if (controller.showWebView.value == false) {
                    if (controller.paymentModel.value != null) {
                      return Obx(() {
                        return Center(
                          child: PaymentResultWidget(
                            paymentModel: controller.paymentModel.value,
                          ),
                        );
                      });
                    }
                    return SizedBox.shrink();
                  }
                  return VnPayWebView(
                    paymentLink:
                        controller.createPaymentResponse.value!.paymentUrl!,
                    onReturnUrl: controller.onReturnUrl,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<VnPayController>();
    super.dispose();
  }
}
