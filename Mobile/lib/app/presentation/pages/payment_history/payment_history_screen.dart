import 'package:dating_app/app/data/models/payment/payment_model.dart';
import 'package:dating_app/app/presentation/pages/payment_history/widgets/payment_history_item.dart';
import 'package:dating_app/app/widgets/paging_list_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/utils/index.dart';
import 'payment_history_controller.dart';
import 'widgets/index.dart';

class PaymentHistoriesScreen extends StatefulWidget {
  const PaymentHistoriesScreen({super.key});

  @override
  State<PaymentHistoriesScreen> createState() => _PaymentHistoriesScreenState();
}

class _PaymentHistoriesScreenState extends State<PaymentHistoriesScreen> {
  final controller = Get.find<PaymentHistoriesController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: ColorUtils.primaryColor,
        title: Text(
          'payment_history'.tr,
          style: const TextStyle(),
        ),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            controller.onRefresh();
          },
          child: CustomListView<PaymentModel>(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            controller: controller.paymentListController,
            shrinkWrap: true,
            emptyWidget: SizedBox(
              height: 0.8.sh,
              child: Center(
                child: Assets.svg.iconNodata.svg(width: 80.w, height: 80.w),
              ),
            ),
            builder: (c, item, i) {
              return PaymentHistoryItem(
                item: item,
                onTap: controller.onTapItem,
              );
            },
            onRefresh: controller.onRefresh,
            firstPageProgressIndicator: const ShimmerPaymentListFirstPage(),
            newPageProgressIndicatorBuilder:
                const ShimmerPaymentListFirstPage(),
            firstPageErrorIndicator: Center(
              child: Assets.svg.iconNodata.svg(width: 80.w, height: 80.w),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Get.delete<PaymentHistoriesController>();
    super.dispose();
  }
}
