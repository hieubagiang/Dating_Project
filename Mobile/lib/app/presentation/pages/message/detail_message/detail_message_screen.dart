import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/call_type.dart';
import 'package:dating_app/app/data/enums/message_type_enum.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:dating_app/app/presentation/pages/message/detail_message/detail_message_controller.dart';
import 'package:dating_app/app/presentation/pages/message/detail_message/widgets/call_message_widget.dart';
import 'package:dating_app/app/widgets/chat_bubble.dart';
import 'package:dating_app/app/widgets/custom_avatar.dart';
import 'package:dating_app/app/widgets/message_input.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../../../common/constants/data_constants.dart';
import '../../../../common/utils/file_helper.dart';
import '../../../../widgets/empty_data_widget.dart';

class DetailMessageScreen extends BaseView<DetailMessageListController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.withOpacity(0.2),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back,
            color: ColorUtils.primaryColor,
          ),
        ),
        title: Row(
          children: <Widget>[
            Stack(
              children: [
                Obx(() {
                  return CustomAvatar(
                    avatarUrl: controller.selectedUser.value.avatarUrl ?? '',
                    padding: 1.w,
                    sizeAvatar: 50.h,
                  );
                }),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: SpaceUtils.spaceMedium,
                    height: SpaceUtils.spaceMedium,
                    decoration: BoxDecoration(
                      color: ColorUtils.activeColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 16.w,
            ),
            Obx(() {
              return Text(
                controller.selectedUser.value.name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorUtils.primaryColor,
                ),
              );
            }),
            const Spacer(),
            IconButton(
              onPressed: () {
                controller.ringCallee(CallType.voice);
              },
              icon: const Icon(
                Icons.call,
                color: ColorUtils.primaryColor,
              ),
            ),
            IconButton(
              onPressed: () {
                controller.ringCallee(CallType.video);
              },
              icon: const Icon(
                Icons.video_call_rounded,
                color: ColorUtils.primaryColor,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          getBody(),
          SizedBox(
            height: 8.h,
          ),
          getBottom(context)
        ],
      ),
    );
  }

  Widget getBottom(context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          return AnimatedCrossFade(
            crossFadeState: controller.isShowMedia.isTrue
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Container(
              child: MessageInput(
                focusNode: controller.focusNode,
                textController: controller.messageTextController,
                onTap: () async {
                  controller.isShowEmoji.value = false;
                },
                onSendMessage: (String message) async {
                  controller.sendMessage();
                },
                onTapAttachMedia: () {
                  controller.isShowMedia.value = !controller.isShowMedia.value;
                },
                onTapAttachFile: () async {
                  //file picker
                  final files = await chooseFiles();
                  controller.sendMessage(files: files);
                },
                onTapEmoji: controller.onTapEmoji,
              ),
            ),
            secondChild: Obx(() {
              if (controller.isShowMedia.isFalse) {
                return const SizedBox.shrink();
              }
              return SizedBox(
                height: 0.4.sh,
                child: MediaPicker(
                  mediaList: controller.mediaList,
                  onPick: (selectedList) async {
                    await controller.sendMessage(listMedia: selectedList);
                    controller.isShowMedia.value = false;
                  },
                  onCancel: controller.onCloseMedia,
                  mediaCount: MediaCount.multiple,
                  mediaType: MediaType.all,
                  decoration: PickerDecoration(
                    actionBarPosition: ActionBarPosition.top,
                    blurStrength: 2,
                    completeText: 'send'.tr,
                    loadingWidget: Center(
                      child: CupertinoActivityIndicator(
                        radius: 15.r,
                        color: ColorUtils.primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
            duration: const Duration(milliseconds: 300),
          );
        }),
        Obx(() {
          return Offstage(
            offstage: controller.isShowEmoji.isFalse,
            child: SizedBox(
              height: 250.h,
              child: EmojiPicker(
                textEditingController: controller.messageTextController,
                config: Config(
                  columns: 7,
                  // Issue: https://github.com/flutter/flutter/issues/28894
                  emojiSizeMax: 32 *
                      (foundation.defaultTargetPlatform == TargetPlatform.iOS
                          ? 1.30
                          : 1.0),
                  verticalSpacing: 0,
                  horizontalSpacing: 0,
                  gridPadding: EdgeInsets.zero,
                  initCategory: Category.RECENT,
                  bgColor: const Color(0xFFF2F2F2),
                  indicatorColor: Colors.blue,
                  iconColor: Colors.grey,
                  iconColorSelected: Colors.blue,
                  backspaceColor: Colors.blue,
                  skinToneDialogBgColor: Colors.white,
                  skinToneIndicatorColor: Colors.grey,
                  enableSkinTones: true,
                  showRecentsTab: true,
                  recentsLimit: 28,
                  replaceEmojiOnLimitExceed: false,
                  noRecents: const Text(
                    'No Recents',
                    style: TextStyle(fontSize: 20, color: Colors.black26),
                    textAlign: TextAlign.center,
                  ),
                  loadingIndicator: const SizedBox.shrink(),
                  tabIndicatorAnimDuration: kTabScrollDuration,
                  categoryIcons: const CategoryIcons(),
                  buttonMode: ButtonMode.MATERIAL,
                  checkPlatformCompatibility: true,
                ),
                onBackspacePressed: () {},
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget getBody() {
    return Expanded(
      child: Obx(() {
        if (controller.dataState.value == BaseStateStatus.init) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return controller.messageList.isEmpty
            ? const EmptyDataWidget(
                message: 'Hai bạn đã được kết nối',
              )
            : GestureDetector(
                onTap: controller.ontapBackground,
                child: ScrollablePositionedList.builder(
                  itemCount: controller.messageList.length,
                  itemBuilder: (context, index) {
                    final message = controller.messageList[index];
                    //if call message
                    if (message.messageType == MessageType.call) {
                      return CallMessageWidget(
                        message: message,
                        isCaller: _isSender(message.senderId),
                        onTapCallBack: () {
                          controller.ringCallee(
                            message.callModel?.callType ?? CallType.voice,
                          );
                        },
                      );
                    }

                    return ChatBubble(
                      isSystem: message.isSystemMessage,
                      isMe: _isSender(message.senderId),
                      messageType:
                          getMessageType(index, controller.messageList),
                      message: message.getMessage(),
                      attachments: message.attachments,
                      profileImg: message.avatarUrl ?? '',
                    );
                  },
                  reverse: true,
                  padding:
                      EdgeInsets.symmetric(horizontal: SpaceUtils.spaceMedium),
                  itemScrollController: controller.itemScrollController,
                  itemPositionsListener: controller.itemPositionsListener,
                ),
              );
      }),
    );
  }

  bool _isSender(String? senderId) =>
      senderId == controller.currentUser.value?.id;

  int getMessageType(int index, List<MessageModel> messageList) {
    if (index == 0) {
      if (messageList.length == 1 ||
          messageList[index].senderId != messageList[index + 1].senderId) {
        return 1;
      } else {
        return 3;
      }
    } else {
      if (index == messageList.length - 1 ||
          messageList[index].senderId != messageList[index + 1].senderId) {
        if (messageList[index].senderId != messageList[index - 1].senderId) {
          return 4;
        } else {
          return 1;
        }
      } else if (messageList[index].senderId ==
          messageList[index + 1].senderId) {
        if (messageList[index].senderId != messageList[index - 1].senderId) {
          return 3;
        } else {
          return 4;
        }
      }
    }
    return 4;
  }
}
