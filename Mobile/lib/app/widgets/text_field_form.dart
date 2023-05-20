import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldNormal extends StatelessWidget {
  const TextFieldNormal({
    Key? key,
    this.hintText = "",
    this.controller,
    this.inputType,
    this.onChanged,
    this.inputFormatters,
    this.maxLength,
    this.enable,
    this.focus,
    this.onTap,
    this.onSubmitted,
    this.label = "",
    this.isPass = false,
    this.prefixWidget,
    this.maxLines = 1,
    this.minLines,
    this.isExpandContent = false,
    this.contentPadding,
  }) : super(key: key);
  final String hintText;
  final TextEditingController? controller;
  final TextInputType? inputType;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function(String)? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focus;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final bool? enable;
  final bool isExpandContent;
  final String label;
  final bool isPass;
  final Widget? prefixWidget;
  final EdgeInsets? contentPadding;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          isExpandContent ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: StyleUtils.style16Bold.copyWith(color: ColorUtils.labelColor),
        ),
        SizedBox(
          height: SpaceUtils.spaceSmall,
        ),
        SizedBox(
          height: isExpandContent ? null : HeightUtils.heightTextField,
          child: TextFormField(
            enabled: enable,
            focusNode: focus,
            controller: controller,
            keyboardType: inputType,
            maxLength: maxLength,
            onTap: () {
              if (onTap != null) {
                onTap!();
              }
            },
            onChanged: onChanged,
            onFieldSubmitted: onSubmitted,
            inputFormatters: inputFormatters,
            obscureText: isPass,
            style: StyleUtils.style18Normal,
            decoration: InputDecoration(
              prefix: prefixWidget,
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorUtils.activeColor),
                borderRadius:
                    BorderRadius.circular(BorderUtils.borderTextField),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorUtils.labelColor),
                borderRadius:
                    BorderRadius.circular(BorderUtils.borderTextField),
              ),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: ColorUtils.dividerColor),
                borderRadius:
                    BorderRadius.circular(BorderUtils.borderTextField),
              ),
              hintText: hintText,
              contentPadding: contentPadding ??
                  EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
              hintStyle: StyleUtils.style14Medium
                  .copyWith(color: ColorUtils.dividerColor),
              counterText: "",
            ),
            maxLines: maxLines,
            minLines: minLines,
          ),
        ),
      ],
    );
  }
}
