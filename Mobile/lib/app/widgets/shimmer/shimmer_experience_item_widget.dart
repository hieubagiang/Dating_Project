import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'index.dart';

class ShimmerExperienceItemWidget extends StatelessWidget {
  final Color? baseColor;

  const ShimmerExperienceItemWidget({Key? key, this.baseColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.w),
        child: Container(
          color: baseColor ?? Colors.white,
          padding: EdgeInsets.only(
            left: 15.w,
            right: 35.w,
            top: 10.w,
            bottom: 10.w,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.w),
                child: ShimmerWidget.rectangular(
                  width: 105.w,
                  height: 75.w,
                ),
              ),
              Flexible(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.w),
                        child: ShimmerWidget.rectangular(
                          height: 25.w,
                        ),
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      ShimmerWidget.rectangular(
                        height: 20.w,
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                      ShimmerWidget.rectangular(
                        height: 20.w,
                      ),
                      SizedBox(
                        height: 3.w,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              ShimmerWidget.rectangular(
                height: 20.w,
                width: 20.w,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
