import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../custom_button.dart';
import 'base_dialog.dart';

class AlertDialogCustom extends BaseDialog {
  final String title;
  final String? description;
  final Function()? onTap;

  AlertDialogCustom(
      {this.description,
      Widget? bodyWidget,
      Widget? titleWidget,
      required BuildContext context,
      this.title = 'Thông báo',
      bool? showLoad,
      this.onTap,
      double width = 533})
      : assert(bodyWidget == null || description == null),
        super(
          context: context,
          width: width,
          titleWidget: Text(
            title,
            textAlign: TextAlign.left,
            style: StyleUtils.style20Bold,
          ),
          bodyWidget: bodyWidget ??
              Text(
                description!,
                style: StyleUtils.style16Normal
                    .copyWith(color: ColorUtils.blackColor),
              ),
          actions: [
            CustomButton(
                label: 'Đồng ý',
                bgColor: ColorUtils.primaryColor,
                onTap: onTap),
          ],
          showLoad: showLoad,
        );
}
