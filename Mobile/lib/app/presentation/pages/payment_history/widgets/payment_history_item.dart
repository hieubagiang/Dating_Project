import 'package:flutter/material.dart';
import 'package:money2/money2.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/utils/index.dart';
import '../../../../data/models/payment/payment_model.dart';
import '../../../../widgets/shimmer/index.dart';

class PaymentHistoryItem extends StatelessWidget {
  final PaymentModel item;
  final Function(PaymentModel)? onTap;
  const PaymentHistoryItem({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap?.call(item);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorUtils.borderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: ColorUtils.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.w),
              ),
              child: Center(
                child: Assets.svg.icPremium.svg(),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'subscription_package'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${item.subscriptionPackage?.name}',
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.w),
                  Text(
                    DateTimeUtils.getStringDate(
                          item.getUpdatedAt(),
                          pattern: Pattern.ddMMyyyyHHmmss,
                        ) ??
                        '',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16.sp,
                    ),
                  )
                  //RichText with TextSpan
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              Money.fromNum(
                item.subscriptionPackage?.price ?? 100000,
                code: 'VND',
              ).format('###,###,### CCC'),
              style: const TextStyle(
                // color: ColorUtils.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 14.w,
            )
          ],
        ),
      ),
    );
  }
}

class PaymentHistoryItemShimmer extends StatelessWidget {
  const PaymentHistoryItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorUtils.shimmerBaseColor,
      highlightColor: ColorUtils.shimmerHighlightColor,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorUtils.borderColor,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.w),
              child: ShimmerWidget.rectangular(
                height: 48.w,
                width: 44.w,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ShimmerWidget.rectangular(
                    height: 14.h,
                    width: 170.w,
                  ),
                  SizedBox(height: 8.w),
                  ShimmerWidget.rectangular(
                    height: 14.h,
                    width: 120.w,
                  ),

                  //RichText with TextSpan
                ],
              ),
            ),
            SizedBox(width: 16.w),
            ShimmerWidget.rectangular(
              height: 14.h,
              width: 80.w,
            ),
          ],
        ),
      ),
    );
  }
}
