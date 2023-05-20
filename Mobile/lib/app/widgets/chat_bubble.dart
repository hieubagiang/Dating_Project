import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/data/enums/attachment_type.dart';
import 'package:dating_app/app/widgets/photo_grid/photo_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../data/models/chat/attachment_model.dart';
import 'photo_grid/photo_grid_widget.dart';
import 'video_player_widget.dart';

class ChatBubble extends StatelessWidget {
  final bool isMe;
  final String profileImg;
  final String message;
  final List<Attachment>? attachments;
  final int messageType;
  final bool isSystem;

  ChatBubble({
    required this.isMe,
    required this.profileImg,
    required this.message,
    required this.messageType,
    this.isSystem = false,
    this.attachments,
  });

  @override
  Widget build(BuildContext context) {
    return isSystem
        ? Padding(
            padding: EdgeInsets.symmetric(vertical: SpaceUtils.spaceMedium),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(message,
                    style: TextStyle(
                        color: ColorUtils.primaryColor, fontSize: 14.sp))
              ],
            ),
          )
        : isMe
            ? Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[messageRender(context)],
                ),
              )
            : Padding(
                padding: EdgeInsets.all(1.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 35.w,
                      height: 35.w,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(profileImg),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: SpaceUtils.spaceMedium,
                    ),
                    (attachments != null && attachments!.isNotEmpty)
                        ? Container(
                            width: 0.6.sw,
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: PhotoGridWidget(
                                imageUrls:
                                    attachments!.map((e) => e.url).toList(),
                                onImageClicked: (index) {
                                  _showPhotoViewWidget(index, context);
                                }),
                          )
                        : Flexible(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.5),
                                  borderRadius: getMessageType(messageType)),
                              child: Padding(
                                padding:
                                    EdgeInsets.all(SpaceUtils.spaceSmall * 1.5),
                                child: Text(
                                  message,
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17.sp),
                                ),
                              ),
                            ),
                          )
                  ],
                ),
              );
  }

  Widget messageRender(BuildContext context) {
    if (attachments != null && attachments!.isNotEmpty) {
      if (attachments!.first.type == AttachmentType.video) {
        return Column(
          children: attachments!
              .map(
                (e) => Container(
                  width: 0.7.sw,
                  margin: EdgeInsets.only(bottom: 8.h),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayerWidget(
                      url: e.url,
                      name: e.fileName,
                      isMedia: e.type.isMedia,
                    ),
                  ),
                ),
              )
              .toList(),
        );
      }
      return Container(
        width: 0.6.sw,
        padding: EdgeInsets.only(bottom: 8.h),
        child: PhotoGridWidget(
          imageUrls: attachments!.map((e) => e.url).toList(),
          onImageClicked: (index) {
            _showPhotoViewWidget(index, context);
          },
        ),
      );
    }
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            color: ColorUtils.primaryColor,
            borderRadius: getMessageType(messageType)),
        child: Padding(
          padding: EdgeInsets.all(SpaceUtils.spaceSmall),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 17.sp),
          ),
        ),
      ),
    );
  }

  void _showPhotoViewWidget(int index, context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext builder) => PhotoViewPage(
              imageUrls: attachments?.map((e) => e.url).toList() ?? [],
              currentIndex: index,
            ));
  }

  getMessageType(messageType) {
    if (isMe) {
      // start message
      if (messageType == 1) {
        return BorderRadius.only(
            topRight: Radius.circular(30.w),
            bottomRight: Radius.circular(5.w),
            topLeft: Radius.circular(30.w),
            bottomLeft: Radius.circular(30.w));
      }
      // middle message
      else if (messageType == 2) {
        return BorderRadius.only(
            topRight: Radius.circular(5.w),
            bottomRight: Radius.circular(5.w),
            topLeft: Radius.circular(30.w),
            bottomLeft: Radius.circular(30.w));
      }
      // end message
      else if (messageType == 3) {
        return BorderRadius.only(
            topRight: Radius.circular(5.w),
            bottomRight: Radius.circular(30.w),
            topLeft: Radius.circular(30.w),
            bottomLeft: Radius.circular(30.w));
      }
      // standalone message
      else {
        return BorderRadius.all(Radius.circular(30.w));
      }
    }
    // for sender bubble
    else {
      // start message
      if (messageType == 1) {
        return BorderRadius.only(
            topLeft: Radius.circular(30.w),
            bottomLeft: Radius.circular(5.w),
            topRight: Radius.circular(30.w),
            bottomRight: Radius.circular(30.w));
      }
      // middle message
      else if (messageType == 2) {
        return BorderRadius.only(
            topLeft: Radius.circular(5.w),
            bottomLeft: Radius.circular(5.w),
            topRight: Radius.circular(30.w),
            bottomRight: Radius.circular(30.w));
      }
      // end message
      else if (messageType == 3) {
        return BorderRadius.only(
            topLeft: Radius.circular(5.w),
            bottomLeft: Radius.circular(30.w),
            topRight: Radius.circular(30.w),
            bottomRight: Radius.circular(30.w));
      }
      // standalone message
      else {
        return BorderRadius.all(Radius.circular(30.w));
      }
    }
  }
}
