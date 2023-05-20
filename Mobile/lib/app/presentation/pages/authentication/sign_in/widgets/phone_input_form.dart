import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneInputForm extends StatelessWidget {
  final Function(String) onChanged;

  const PhoneInputForm({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      style: StyleUtils.style20Medium,
      onChanged: onChanged,
      inputFormatters: [
        LengthLimitingTextInputFormatter(9),
      ],
      decoration: InputDecoration(
          fillColor: ColorUtils.thirdColor,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          contentPadding: EdgeInsets.symmetric(
              horizontal: SpaceUtils.spaceMedium,
              vertical: SpaceUtils.spaceSmall),
          prefix: Padding(
            padding: EdgeInsets.only(right: SpaceUtils.spaceSmall / 4),
            child: Text(
              '+84',
              style: StyleUtils.style20Medium,
            ),
          )),
    );
  }
}
