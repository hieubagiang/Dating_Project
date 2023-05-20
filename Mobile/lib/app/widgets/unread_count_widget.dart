import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnreadCount extends StatelessWidget {
  final int unreadMail;
  final int unreadSurvey;
  final Decoration? decoration;
  final double height;

  const UnreadCount({
    Key? key,
    this.unreadMail = 0,
    this.unreadSurvey = 0,
    this.decoration,
    this.height = 80,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Column label
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorUtils.greyColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: height.h,
                  alignment: Alignment.center,
                  child: Text(
                    'unread_count'.tr,
                    style: StyleUtils.style16Normal,
                  ),
                )
              ],
            ),
          ),
          // Mail count
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorUtils.greyColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: height,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'mail'.tr,
                      style: StyleUtils.style16Normal,
                    ),
                  ),
                ),
                _totalUnread(unreadMail),
              ],
            ),
          ),
          // Survey count
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: ColorUtils.greyColor),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    height: height,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'survey'.tr,
                      style: StyleUtils.style16Normal,
                    ),
                  ),
                ),
                _totalUnread(unreadSurvey),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _totalUnread(int total) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: SpaceUtils.spaceMedium,
      ),
      padding: EdgeInsets.symmetric(
        vertical: SpaceUtils.spaceSmall,
        horizontal: SpaceUtils.spaceMediumLarge,
      ),
      decoration: BoxDecoration(
        color: total > 0 ? ColorUtils.redNotiColor : ColorUtils.greyNotiColor,
        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
      ),
      alignment: Alignment.center,
      child: Text(
        total.toString(),
        style: StyleUtils.style16Bold.copyWith(color: ColorUtils.whiteColor),
      ),
    );
  }
}
