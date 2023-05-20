import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String? label;
  final Color? labelColor;
  final Function()? onPress;
  final Widget? children;
  final Widget? icon;
  final Color? color;
  final EdgeInsets? padding;
  final double? height;

  const ButtonWidget(
      {Key? key,
      this.label,
      this.onPress,
      this.icon,
      this.children,
      this.color,
      this.labelColor,
      this.padding,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (icon == null)
        ? ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: color ?? ColorUtils.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: onPress,
            child: Container(
                height: height,
                width: ScreenUtil().screenWidth,
                padding: padding ??
                    EdgeInsets.symmetric(
                        vertical: SpaceUtils.spaceSmall,
                        horizontal: SpaceUtils.spaceMedium),
                child: Center(child: children ?? _buildLabel())))
        : ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
                primary: color ?? ColorUtils.blueColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 5),
            onPressed: onPress,
            icon: icon!,
            label: SizedBox(
                child: Container(
                    width: ScreenUtil().screenWidth,
                    padding: padding ??
                        EdgeInsets.symmetric(
                            vertical: SpaceUtils.spaceSmall,
                            horizontal: SpaceUtils.spaceMedium),
                    child: Center(child: _buildLabel()))));
  }

  Text _buildLabel() {
    return Text(
      '$label',
      style: StyleUtils.style16Normal.copyWith(
          color: labelColor ?? ColorUtils.secondaryColor, fontSize: 18.sp),
    );
  }
}
