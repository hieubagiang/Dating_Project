import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _Const {
  static const int expandTextAnimationLength = 200;
  static const int descriptionMaxLength = 300;
}

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  bool _isExpanded = false;
  bool _enableExpanded = false;

  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > _Const.descriptionMaxLength) {
      firstHalf = widget.text.substring(0, _Const.descriptionMaxLength);
      secondHalf = widget.text
          .substring(_Const.descriptionMaxLength, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = "";
    }
    _enableExpanded = widget.text.length > _Const.descriptionMaxLength;
    _isExpanded = !_enableExpanded;
  }

  @override
  Widget build(BuildContext context) {
    if (!_enableExpanded) {
      return _buildExpandedText();
    }
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: AnimatedCrossFade(
        duration:
            const Duration(milliseconds: _Const.expandTextAnimationLength),
        crossFadeState:
            !_isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: _buildCollapsedText(),
        secondChild: _buildExpandedText(),
      ),
    );
  }

  Widget _buildExpandedText() {
    return Text(
      widget.text,
      style: StyleUtils.style16Normal,
    );
  }

  Widget _buildCollapsedText() {
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            text: firstHalf,
            style: StyleUtils.style16Normal,
          ),
          TextSpan(
            text: '...' + 'show_more'.tr,
            style: StyleUtils.style16Bold.copyWith(color: ColorUtils.greyColor),
          ),
        ],
      ),
    );
  }
}
