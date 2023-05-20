import 'package:flutter/material.dart';

class CustomButtonTCG extends StatelessWidget {
  const CustomButtonTCG({
    required this.icon,
    this.onTap,
    this.padding = EdgeInsets.zero,
    this.bgColor,
    this.splashColor,
    this.borderRadius,
    Key? key,
  }) : super(key: key);

  /// Icon or Svg
  final Widget icon;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final Color? bgColor;
  final Color? splashColor;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: bgColor ?? Colors.transparent,
      borderRadius: borderRadius ?? BorderRadius.circular(2.0),
      child: InkWell(
        splashColor: splashColor ?? Colors.grey.withOpacity(0.3),
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: padding,
            child: icon,
          ),
        ),
      ),
    );
  }
}
