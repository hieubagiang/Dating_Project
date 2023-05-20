import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';

class EmptyDataWidget extends StatelessWidget {
  final String? message;

  const EmptyDataWidget({Key? key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /*SvgPicture.asset(
            IconUtils.emptyDataIcon,
            width: HeightUtils.iconSize,
            height: HeightUtils.iconSize,
          ),*/
          SizedBox(height: SpaceUtils.spaceMedium),
          Text(
            message ?? 'empty_data'.tr,
            style:
                StyleUtils.style14Bold.copyWith(color: ColorUtils.primaryColor),
          ),
        ],
      ),
    );
  }
}
