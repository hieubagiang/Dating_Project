import 'package:dating_app/app/presentation/pages/payment_history/widgets/payment_history_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../widgets/shimmer/list_view_shimmer_first_page.dart';

class ShimmerPaymentListFirstPage extends StatelessWidget {
  const ShimmerPaymentListFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListViewShimmerFirstPage(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      item: const PaymentHistoryItemShimmer(),
      separatorItem: SizedBox(
        width: 16.w,
      ),
    );
  }
}
