import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';

class LoadingLogoWidget extends StatelessWidget {
  const LoadingLogoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 56.w,
          width: 56.w,
          child: const CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(ColorUtils.primaryColor),
          ),
        ),
        Assets.images.logo.image(height: 32.w, width: 32.w),
      ],
    );
  }
}
