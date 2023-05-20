import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

mixin ValidateFormMixin {
  RxBool isAutoValidate = RxBool(false);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool get validateForm {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    isAutoValidate.value = true;
    return false;
  }
}
