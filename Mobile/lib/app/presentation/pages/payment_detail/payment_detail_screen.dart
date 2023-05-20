import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/utils/index.dart';
import '../vn_pay/widgets/payment_result_card.dart';
import 'payment_detail_controller.dart';

class PaymentDetailScreen extends StatefulWidget {
  const PaymentDetailScreen({super.key});

  @override
  State<PaymentDetailScreen> createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  final controller = Get.find<PaymentDetailController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'payment_detail'.tr,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Obx(() {
          if (controller.baseStateStatus.value == BaseStateStatus.init) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 16.r,
                color: ColorUtils.primaryColor,
              ),
            );
          }
          return PaymentResultWidget(
            paymentModel: controller.paymentModel.value,
          );
        }),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<PaymentDetailController>();
    super.dispose();
  }
}
