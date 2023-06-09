import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SpaceUtils {
  static final double spaceZero = 0.0;
  static final double spaceSmaller = 4.w;
  static final double spaceSmall = 8.w;

  static final double spaceMedium = 16.w;
  static final double spaceMediumLarge = 24.w;
  static final double spaceLarge = 32.w;
  static final double spaceLarger = 48.w;
  static final double spaceMoreLarge = 60.w;
  static final double spaceExtraLarge = 80.w;
}

class BorderUtils {
  static final double borderTextField = 8.w;
  static final double borderButton = 6.w;
  static final double borderLoginButton = 50.w;
  static final double borderRadius = 20.w;
  static final double borderButtonLarge = 36.w;
  static final double borderWidth = 4.0;
  static final double borderTags = 2.w;
  static final double borderCard = 25.w;
}

class HeightUtils {
  static final double heightTextField = 40.0.h;
  static final double heightSettingItem = 400.h;
  static final double heightLine = 1.h;
  static final double heightLineMedium = 2.h;
  static final double heightButtonSmall = 40.0.h;
  static final double heightButtonMedium = 60.0.h;
  static final double heightButtonLarge = 80.0.h;
  static final double heightGroupImageThumbnail = 84.w;
  static final double heightImageThumbnail = 71.w;
  static final double heightImage = 120.h;
  static final double heightMedium = 16.h;
  static final double heightLarge = 24.h;
  static final double heightExtraLarge = 32.h;
  static final double heightSearchBox = 48.h;
  static final double heightTagSmall = 52.h;
  static final double heightExtraLargeDivider = 5.h;

  static final double heightComment = 240.h;
}

class WidthUtils {
  static final double widthSmall = 80.w;
  static final double widthSmallMedium = 120.w;
  static final double widthMedium = 240.w;
  static final double widthLarge = 340.w;
  static final double widthThumbnail = 96.w;
}

class FontSizeUtils {
  static final double toastFontSize = 16.sp;
}

class SizeUtils {
  static final double iconSizeSmall = 16.w;
  static final double iconSize = 24.w;
  static final double iconSizeLarge = 36.w;
  static final double iconSizeExtraLarge = 48.w;
  static final double floatingButtonSize = 56.w;
  static final double avatarSize = 80.w;
}

class LayoutConstants {
  static final paddingHorizontalSmall = SpaceUtils.spaceSmall;
  static final paddingHorizontalApp = SpaceUtils.spaceMedium;
  static final paddingVerticalApp = SpaceUtils.spaceMedium;
}

class ShadowUtils {
  static final BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 15,
    offset: Offset(0, 1),
  );
  static final BoxShadow bottomThinShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 1,
    offset: Offset(0, 1), // changes position of shadow
  );
  static final BoxShadow topThinShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.2),
    spreadRadius: 1,
    blurRadius: 1,
    offset: Offset(0, -1), // changes position of shadow
  );
}
