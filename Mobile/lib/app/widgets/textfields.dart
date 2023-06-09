import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

class TextFields extends StatefulWidget {
  final MultiValidator? validate;
  final TextEditingController? controller;
  final String? hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final bool? secure, isSignupfield;
  final FocusNode? focusNode;

  const TextFields({
    Key? key,
    @required this.validate,
    @required this.controller,
    @required this.hintText,
    @required this.icon,
    this.focusNode,
    this.suffixIcon,
    this.secure = false,
    this.isSignupfield = true,
  }) : super(key: key);

  @override
  TextFieldsState createState() => TextFieldsState();
}

class TextFieldsState extends State<TextFields> {
  // dynamic validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      style: widget.isSignupfield!
          ? const TextStyle(color: Colors.white, fontSize: 18)
          : null,
      cursorColor: widget.isSignupfield! ? Colors.white : Colors.black,
      validator: widget.validate!,
      controller: widget.controller,
      obscureText: widget.secure!,
      decoration: InputDecoration(
        fillColor: widget.isSignupfield! ? Colors.white.withOpacity(0.2) : null,
        filled: widget.isSignupfield,
        prefixIcon: Icon(
          widget.icon,
          color: widget.isSignupfield! ? Colors.white : Colors.grey,
        ),
        suffixIcon: widget.suffixIcon,
        hintText: widget.hintText,
        hintStyle: widget.isSignupfield!
            ? TextStyle(fontSize: 17, color: Colors.white.withOpacity(0.5))
            : null,
        errorStyle: widget.isSignupfield!
            ? const TextStyle(color: Colors.yellow)
            : null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color:
                widget.isSignupfield! ? Colors.white : ColorUtils.primaryColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.isSignupfield!
                ? Colors.white.withOpacity(0.0)
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(25.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: widget.isSignupfield! ? Colors.yellow : Colors.red,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: widget.isSignupfield! ? Colors.yellow : Colors.red,
          ),
        ),
      ),
    );
  }
}
