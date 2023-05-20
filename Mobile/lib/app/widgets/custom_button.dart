import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Widget? icon;
  final String label;
  final VoidCallback? onTap;
  final TextStyle? labelstyle;
  final Color bgColor;
  final double height;

  const CustomButton({
    required this.label,
    this.onTap,
    this.icon,
    this.bgColor = Colors.blue,
    this.height = 38.0,
    Key? key,
    this.labelstyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: Material(
        color: bgColor,
        borderRadius: BorderRadius.circular(4.0),
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon ?? SizedBox(),
                if (icon != null) SizedBox(width: 12.w),
                Text(
                  label,
                  style: labelstyle ??
                      TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1.53,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
