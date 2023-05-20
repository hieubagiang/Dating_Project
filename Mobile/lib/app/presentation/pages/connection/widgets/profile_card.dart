import 'dart:ui';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/widgets/cache_image_widget.dart';
import 'package:dating_app/app/widgets/image_overlay_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_svg/svg.dart';

import '../../feed/controller/feed_controller.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {Key? key,
      this.onTap,
      this.onTapLike,
      this.onTapDislike,
      this.ratio,
      this.titleBottomPosition,
      this.titleLeftPosition,
      this.width,
      required this.heroTag,
      required this.name,
      required this.age,
      required this.id,
      required this.imageUrl,
      this.padding,
      this.fontSize,
      this.isMe = false})
      : super(key: key);
  final String id;
  final String heroTag;
  final String name;
  final int age;
  final String imageUrl;
  final double? width;
  final double? ratio;
  final double? fontSize;
  final double? titleBottomPosition;
  final double? titleLeftPosition;
  final Function()? onTap;
  final Function()? onTapLike;
  final Function()? onTapDislike;
  final EdgeInsets? padding;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Container(
          margin: padding ?? EdgeInsets.zero,
          color: ColorUtils.transparent,
          child: Hero(
            tag: heroTag,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(BorderUtils.borderCard),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AspectRatio(
                    aspectRatio: ratio ?? 0.7,
                    child: CachedImageWidget(
                      fit: BoxFit.cover,
                      url: imageUrl,
                    ),
                  ),
                  const ImageOverlayFilter(),
                  Positioned(
                      bottom: titleBottomPosition ?? 0,
                      left: titleLeftPosition ?? 0,
                      child: SizedBox(
                        width: width ??
                            ScreenUtil().screenWidth * 0.8 -
                                SpaceUtils.spaceSmall,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildCardTitle(),
                            if (!(onTapDislike == null && onTapLike == null))
                              _buildCardAction()
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCardAction() {
    return buildBlur(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: SpaceUtils.spaceMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: isMe
                  ? [
                      CountdownTimer(
                          endTime: Get.find<FeedController>()
                              .boostProfileStatus
                              .value!
                              .expireAt!
                              .millisecondsSinceEpoch,
                          textStyle: StyleUtils.style16Medium
                              .copyWith(color: CupertinoColors.white))
                    ]
                  : [
                      if (onTapDislike != null)
                        Expanded(
                          child: GestureDetector(
                            onTap: onTapDislike,
                            child: SvgPicture.asset(
                              IconUtils.icClose,
                              height: SizeUtils.iconSizeSmall,
                              width: SizeUtils.iconSizeSmall,
                            ),
                          ),
                        ),
                      if (onTapLike != null)
                        Expanded(
                          child: GestureDetector(
                            onTap: onTapLike,
                            child: SvgPicture.asset(
                              IconUtils.icHeart,
                              height: SizeUtils.iconSizeSmall,
                              width: SizeUtils.iconSizeSmall,
                            ),
                          ),
                        ),
                    ],
            ),
          ),
          if (onTapLike != null && onTapDislike != null && !isMe)
            Container(
              color: ColorUtils.whiteColor.withOpacity(0.5),
              height: 55.h,
              width: 1,
            ),
        ],
      ),
    );
  }

  Widget _buildCardTitle() {
    return Padding(
      padding: EdgeInsets.only(
        bottom: SpaceUtils.spaceSmall,
        left: SpaceUtils.spaceMedium,
        right: SpaceUtils.spaceSmall,
      ),
      child: Text(
        '$name, $age',
        style: StyleUtils.style24Normal.copyWith(
            fontSize: fontSize?.sp,
            color: ColorUtils.whiteColor,
            decoration: TextDecoration.none),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget buildBlur({
    required Widget child,
    BorderRadius? borderRadius,
    double sigmaX = 10,
    double sigmaY = 10,
  }) =>
      ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
          child: child,
        ),
      );
}
