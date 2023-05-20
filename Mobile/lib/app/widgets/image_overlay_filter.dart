import 'dart:ui';

import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';

class ImageOverlayFilter extends StatelessWidget {
  const ImageOverlayFilter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 0.0, sigmaY: 0.0),
      child: Container(
        decoration: BoxDecoration(
          color: ColorUtils.blackColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(BorderUtils.borderCard),
        ),
      ),
    );
  }
}
