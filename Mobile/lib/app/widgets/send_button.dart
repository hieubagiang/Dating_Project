import 'package:flutter/material.dart';

class _Const {
  static const switchAnimationDuration = 200;
}

class MessageSendButton extends StatelessWidget {
  /// Returns a [MessageSendButton] with the given [timeOut], [isIdle],
  /// [isCommandEnabled], [isEditEnabled], [idleSendButton], [activeSendButton],
  /// [onSendMessage].
  const MessageSendButton({
    Key? key,
    this.isIdle = true,
    this.isCommandEnabled = false,
    this.isEditEnabled = false,
    this.idleSendButton,
    this.activeSendButton,
    required this.onSendMessage,
  }) : super(key: key);

  /// If true the button will be disabled.
  final bool isIdle;

  /// True if a command is being sent.
  final bool isCommandEnabled;

  /// True if in editing mode.
  final bool isEditEnabled;

  /// The widget to display when the button is disabled.
  final Widget? idleSendButton;

  /// The widget to display when the button is enabled.
  final Widget? activeSendButton;

  /// The callback to call when the button is pressed.
  final VoidCallback onSendMessage;

  @override
  Widget build(BuildContext context) {
    late Widget sendButton;
    if (isIdle) {
      sendButton = idleSendButton ?? _buildIdleSendButton(context);
    } else {
      sendButton = activeSendButton != null
          ? InkWell(
              onTap: onSendMessage,
              child: activeSendButton,
            )
          : _buildSendButton(context);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: _Const.switchAnimationDuration),
      child: sendButton,
    );
  }

  Widget _buildIdleSendButton(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(8), child: _getIdleSendIcon());
  }

  Widget _buildSendButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: IconButton(
        onPressed: onSendMessage,
        splashRadius: 24,
        constraints: const BoxConstraints.tightFor(
          height: 24,
          width: 24,
        ),
        icon: _getSendIcon(),
      ),
    );
  }

  Widget _getIdleSendIcon() {
    return const Icon(Icons.arrow_circle_up);
  }

  Widget _getSendIcon() {
    if (isEditEnabled) {
      return const Icon(Icons.send);
    } else {
      return const Icon(Icons.arrow_circle_up);
    }
  }
}
