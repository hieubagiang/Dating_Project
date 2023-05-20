import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:flutter/material.dart';

class CallMessageWidget extends StatelessWidget {
  final MessageModel message;
  final bool isCaller;
  final VoidCallback onTapCallBack;

  const CallMessageWidget({
    Key? key,
    required this.message,
    required this.isCaller,
    required this.onTapCallBack,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCallBack,
      child: Container(
        alignment: isCaller ? Alignment.centerRight : Alignment.centerLeft,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isCaller && message.avatarUrl != null)
              Container(
                width: 35.w,
                height: 35.w,
                margin: EdgeInsets.only(right: 16.w),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(message.avatarUrl ?? ''),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            Container(
              alignment:
                  isCaller ? Alignment.centerRight : Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
              ).copyWith(top: 8.h, bottom: 8.h),
              decoration: BoxDecoration(
                color: ColorUtils.greyColor,
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: ColorUtils.greyColor),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  message.callModel?.getCallIcon(isCaller: isCaller) ??
                      Container(),
                  SizedBox(
                    width: 8.w,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.callModel?.getCallTitle(isCaller: isCaller) ??
                              '',
                          style: TextStyle(
                            color: ColorUtils.blackColor.withOpacity(0.8),
                            fontSize: 17.sp,
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Flexible(
                          child: Text(
                            message.callModel
                                    ?.getCallMessage(isCaller: isCaller) ??
                                '',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.8)),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
