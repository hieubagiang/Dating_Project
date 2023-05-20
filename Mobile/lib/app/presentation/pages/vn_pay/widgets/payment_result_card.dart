import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/models/payment/payment_model.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money2/money2.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../../data/enums/payment_status_enum.dart';

class PaymentResultWidget extends StatelessWidget {
  final PaymentModel paymentModel;

  const PaymentResultWidget({Key? key, required this.paymentModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32.w),
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 48.w),
            child: paymentModel.status == PaymentStatusType.success
                ? _buildSuccessIcon()
                : _buildFailIcon(),
          ),
          Text(
            paymentModel.status == PaymentStatusType.success
                ? 'payment_successful'.tr
                : 'payment_failed'.tr,
            style: TextStyle(
              color: ColorUtils.primaryColor,
              fontSize: 24.sp,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'payment_description'.trParams(
              {
                'method': paymentModel.paymentMethod?.tr ?? 'VnPay',
              },
            ),
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16.sp,
            ),
          ),
          //money amount
          // Text(
          //   Money.fromNum(
          //     paymentModel.subscriptionPackage?.price ?? 100000,
          //     code: 'VND',
          //   ).format('###,###,### CCC'),
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: 24.sp,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 36.h),
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 1,
            ),
          ),
          rowInfo(title: 'ref_number'.tr, value: paymentModel.paymentId ?? ''),
          SizedBox(height: 16.h),
          rowInfo(
            title: 'payment_time'.tr,
            value: DateTimeUtils.getStringDate(
                  paymentModel.getCreatedAt(),
                  pattern: Pattern.ddMMyyyyHHmmss,
                ) ??
                '',
          ),
          SizedBox(height: 16.h),
          rowInfo(
            title: 'payment_user'.tr,
            value: Get.find<MainController>().currentUser.value?.name ?? '',
          ),

          SizedBox(height: 16.h),
          rowInfo(
            title: 'subscription_package'.tr,
            value: paymentModel.subscriptionPackage?.name ?? '',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Divider(
              color: Colors.grey.shade300,
              thickness: 1,
              height: 1,
            ),
          ),
          rowInfo(
            title: 'amount'.tr,
            value: Money.fromNum(
              paymentModel.subscriptionPackage?.price ?? 100000,
              code: 'VND',
            ).format('###,###,### CCC'),
          ),
        ],
      ),
    );
  }

  Row rowInfo({required String title, required String value}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 16.sp,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessIcon() {
    return RippleAnimation(
      color: Colors.green,
      delay: const Duration(milliseconds: 300),
      repeat: true,
      minRadius: 32.w,
      ripplesCount: 3,
      duration: const Duration(milliseconds: 9 * 300),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.green,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.check_sharp,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  Widget _buildFailIcon() {
    return RippleAnimation(
      color: Colors.red,
      delay: const Duration(milliseconds: 300),
      repeat: true,
      minRadius: 32.w,
      ripplesCount: 3,
      duration: const Duration(milliseconds: 9 * 300),
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.close_sharp,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }
}
