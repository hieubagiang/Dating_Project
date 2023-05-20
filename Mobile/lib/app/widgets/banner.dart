import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 390.h,
      child: Hero(
        tag: 'banner',
        child: Material(
          type: MaterialType.transparency, // likely needed
          child: Stack(
            children: [
              Positioned(
                  left: 64.w,
                  top: 90.w,
                  child: Image.asset(
                    ImageUtils.heart,
                    width: 64.w,
                  )),
              Positioned(
                  right: 0,
                  child: SvgPicture.asset(
                    ImageUtils.coupleImage,
                    height: 390.h,
                  )),
              Positioned(
                  left: 28.h,
                  top: 230.h,
                  child: SizedBox(
                    width: 1.sw / 2,
                    child: Text(
                      'login_to_a_lovely_life'.tr,
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.primaryColor,
                          decoration: TextDecoration.none),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
