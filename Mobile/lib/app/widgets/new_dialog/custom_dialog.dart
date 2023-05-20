import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:flutter/material.dart';

import '../custom_button.dart';

class Consts {
  Consts._();

  static const double padding = 15.0;
  static const double avatarRadius = 66.0;
}

class CustomDialog extends StatelessWidget {
  static Future<void> show(
    BuildContext context, {
    String title = 'Thông báo',
    String description = '',
    required VoidCallback onAccept,
    VoidCallback? onCancel,
  }) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => CustomDialog(
        title: title,
        description: description,
        onAccept: onAccept,
        onCancel: onCancel,
      ),
    );
  }

  final String title;
  final String description;
  final VoidCallback onAccept;
  final String acceptText;
  final VoidCallback? onCancel;
  final String cancelText;
  final double width;

  CustomDialog({
    this.title = 'Thông báo',
    this.description = '',
    required this.onAccept,
    this.acceptText = 'ĐỒNG Ý',
    this.onCancel,
    this.cancelText = 'HỦY',
    this.width = 533.0,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 24.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                color: ColorUtils.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.sp),
            Text(
              description,
              style: TextStyle(
                fontSize: 16.sp,
                color: ColorUtils.primaryTextColor,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              height: 38.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  onCancel != null
                      ? ElevatedButton(
                          onPressed: onCancel,
                          child: Text(
                            cancelText,
                            style: TextStyle(color: ColorUtils.primaryColor),
                          ))
                      : SizedBox(),
                  SizedBox(width: onCancel != null ? 8.w : 0.w),
                  CustomButton(
                    label: acceptText,
                    bgColor: ColorUtils.primaryColor,
                    onTap: onAccept,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
