import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../common/base/base_view_view_model.dart';
import '../../../data/enums/call_status_enum.dart';
import 'call_controller.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({super.key});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  final controller = Get.find<CallController>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Container(
            padding: const EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              image: controller.callModel.value?.receiver?.avatar == null
                  ? null
                  : DecorationImage(
                      image: CachedNetworkImageProvider(
                          controller.callModel.value?.receiver?.avatar ?? ''),
                      fit: BoxFit.cover,
                      opacity: 0.8,
                    ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 0.1.sh),
                  alignment: Alignment.center,
                  child: RippleAnimation(
                    color: Colors.white,
                    delay: const Duration(milliseconds: 1000),
                    repeat: true,
                    minRadius: 90,
                    ripplesCount: 3,
                    duration: const Duration(milliseconds: 3 * 1000),
                    child: Obx(() {
                      return CustomAvatar(
                          sizeAvatar: 120.w,
                          borderColor: Colors.white,
                          padding: 2,
                          avatarUrl:
                              controller.callModel.value?.receiver?.avatar);
                    }),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 24.h),
                  alignment: Alignment.center,
                  child: Obx(() {
                    return Text(
                      controller.callModel.value?.receiver?.name ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w500,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                //calling text
                Container(
                  padding: EdgeInsets.only(top: 24.h),
                  alignment: Alignment.center,
                  child: Obx(() {
                    return Text(
                      controller.callModel.value?.callStatus ==
                              CallStatusType.started
                          ? 'Calling...'
                          : 'ringing'.tr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w500,
                        shadows: const [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: InkWell(
                      borderRadius: BorderRadius.circular(32),
                      onTap: () {
                        controller.stopRinging(isCancelled: true);
                      },
                      child: RippleAnimation(
                        color: Colors.white,
                        delay: const Duration(milliseconds: 1000),
                        repeat: true,
                        minRadius: 30,
                        ripplesCount: 3,
                        duration: const Duration(milliseconds: 3 * 1000),
                        child: Container(
                            height: 64.w,
                            width: 64.w,
                            padding: EdgeInsets.all(8.w),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.call_end,
                              color: Colors.white,
                            )),
                      )),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
