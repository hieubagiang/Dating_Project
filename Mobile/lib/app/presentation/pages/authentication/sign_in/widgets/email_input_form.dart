import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BaseInputForm extends StatelessWidget {
  final TextEditingController textController;
  final List<TextInputFormatter>? inputFormatters;
  final String? hintText;
  final Widget? prefixWidget;
  final bool? isObscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final String? labelText;
  final Color? backgroundColor;

  const BaseInputForm({
    Key? key,
    required this.textController,
    this.inputFormatters,
    this.hintText,
    this.prefixWidget,
    this.isObscureText,
    this.keyboardType,
    this.validator,
    this.labelText,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: keyboardType,
      validator: validator,
      style: StyleUtils.style20Medium.copyWith(color: ColorUtils.primaryColor),
      obscureText: isObscureText ?? false,
      inputFormatters: inputFormatters,
      obscuringCharacter: '●',
      decoration: InputDecoration(
          labelText: labelText,
          fillColor: backgroundColor ?? ColorUtils.lightPrimary,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: ColorUtils.primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: BorderSide(color: ColorUtils.primaryColor),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: SpaceUtils.spaceMedium,
            vertical: SpaceUtils.spaceSmall,
          ),
          hintText: hintText,
          prefix: prefixWidget),
    );
  }
}
