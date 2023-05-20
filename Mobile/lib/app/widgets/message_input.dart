import 'dart:async';

import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';

import 'custom_button_tcg.dart';
import 'send_button.dart';

class _Const {
  static const animationDuration = 300;
}

class MessageInput extends StatefulWidget {
  final Function()? onTap;
  final Function()? onTapCreatePoll;
  final bool isEnable;

  const MessageInput({
    Key? key,
    this.onTap,
    this.isEnable = true,
    this.onTapAttachMedia,
    this.onChanged,
    required this.textController,
    this.onSendMessage,
    this.onTapEmoji,
    this.isOpenGallery = false,
    this.onTapCloseGallery,
    this.onTapAttachFile,
    this.onTapCreatePoll,
    this.errorText,
    this.focusNode,
  }) : super(key: key);
  final Function(String)? onChanged;
  final Function()? onTapAttachMedia;
  final Function()? onTapAttachFile;
  final TextEditingController textController;
  final Function(String)? onSendMessage;
  final Function()? onTapEmoji;
  final Function()? onTapCloseGallery;
  final bool isOpenGallery;
  final String? errorText;
  final FocusNode? focusNode;

  @override
  State<MessageInput> createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  String? convertedString = '';

  late FocusNode _focusNode;
  bool showSendButton = true;
  bool isTyping = false;
  StreamSubscription? _chatDetailSubscription;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    widget.textController.addListener(textListener);
    /* _chatDetailSubscription =
        Get.find<DetailMessageListController>().stream.listen((state) {
      showSendButton = (state.selectedAssets?.isNotEmpty ?? false) ||
          state.selectedReplyMessage != null ||
          state.inputtedMessage.isNotEmpty;
      setState(() {});
    });*/
  }

  void textListener() {
    isTyping = widget.textController.text.trim().isNotEmpty;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 2.w, left: 2.w),
            child: _buildLeftActionView(),
          ),
          Flexible(
            child: TextFormField(
              controller: widget.textController,
              style: StyleUtils.body2,
              minLines: 1,
              maxLines: 5,
              maxLength: 500,
              focusNode: _focusNode,
              readOnly: widget.isOpenGallery,
              decoration: InputDecoration(
                counterText: '',
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorText: widget.errorText,
                focusedBorder: InputBorder.none,
                errorStyle:
                    StyleUtils.textNormal12Style.copyWith(color: Colors.red),
                hintText:
                    widget.isOpenGallery ? null : 'input_message_hint_text'.tr,
                hintStyle: StyleUtils.buttonText2
                    .copyWith(color: Colors.grey.shade600),
              ),
              onChanged: (value) {
                widget.onChanged?.call(value);
              },
              onTap: () {
                widget.onTap?.call();
              },
            ),
          ),
          _buildRightAction(),
        ],
      ),
    );
  }

  Widget _buildRightAction() {
    if (true) {
      return AnimatedCrossFade(
          firstChild: MessageSendButton(
            onSendMessage: () {
              convertedString = widget.textController.text;
              widget.onSendMessage?.call(convertedString ?? '');
            },
            isIdle: false,
            activeSendButton: CustomButtonTCG(
              padding: EdgeInsets.all(8.w),
              icon: Icon(Icons.send,
                  color: ColorUtils.primaryColor2, size: 32.sp),
            ),
            isEditEnabled: true,
          ),
          secondChild: _buildActionView(),
          crossFadeState:
              isTyping ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          duration: Duration(milliseconds: _Const.animationDuration));
    }
  }

  AnimatedCrossFade _buildLeftActionView() {
    return AnimatedCrossFade(
      crossFadeState: !widget.isOpenGallery
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      firstCurve: Curves.easeOut,
      secondCurve: Curves.easeIn,
      firstChild: CustomButtonTCG(
        padding: EdgeInsets.all(10.w),
        icon: Assets.svg.icEmoji.svg(),
        onTap: widget.onTapEmoji,
      ),
      secondChild: CustomButtonTCG(
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: ColorUtils.primaryColor2,
          size: 32.sp,
        ),
        onTap: widget.onTapCloseGallery,
      ),
      duration: const Duration(milliseconds: 200),
      alignment: Alignment.center,
    );
  }

  Wrap _buildActionView() {
    return Wrap(
      children: [
        CustomButtonTCG(
          icon: Assets.svg.icAttachMedia.svg(),
          padding: EdgeInsets.all(10.w),
          onTap: !widget.isEnable ? null : widget.onTapAttachMedia,
        ),
        CustomButtonTCG(
          icon: Assets.svg.icAttachFile.svg(),
          padding: EdgeInsets.all(10.w),
          onTap: !widget.isEnable ? null : widget.onTapAttachFile,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _chatDetailSubscription?.cancel();
    widget.textController.removeListener(textListener);
    super.dispose();
  }
}
