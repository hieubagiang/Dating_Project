import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/cupertino.dart';

class SettingItem extends StatefulWidget {
  final String? icon;
  final String? title;
  final bool? value;
  final Function(bool tick)? onChanged;
  final bool? showBottomLine;

  const SettingItem({
    Key? key,
    this.icon,
    this.title,
    this.value,
    this.onChanged,
    this.showBottomLine = false,
  }) : super(key: key);

  @override
  SettingItemState createState() => SettingItemState();
}

class SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceMedium),
      padding: EdgeInsets.symmetric(
        vertical: SpaceUtils.spaceMedium,
        horizontal: SpaceUtils.spaceMedium,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorUtils.greyColor,
            width: HeightUtils.heightLine,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.title!,
              style: StyleUtils.style14Bold,
            ),
          ),
          CupertinoSwitch(
            value: widget.value!,
            onChanged: widget.onChanged,
            activeColor: ColorUtils.primaryColor,
            trackColor: ColorUtils.trackColor,
          )
        ],
      ),
    );
  }
}
