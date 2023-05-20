import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

mixin EmailAuthenticationMixin {
  TextEditingController emailTextController = TextEditingController();
  TextEditingController userTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  TextEditingController rePasswordTextController = TextEditingController();
  RxBool isSignUpWithEmail = RxBool(false);
  RxBool isValidInputSignUp = RxBool(false);
  RxBool isValidInputLoginWithEmail = RxBool(false);
  bool get isMatchPassword =>
      passwordTextController.text == rePasswordTextController.text;

  void onTapSignUpWithEmailText() {
    isSignUpWithEmail.value = true;
  }

  void onTapSignInWithEmailText() {
    isSignUpWithEmail.value = false;
  }

  void inputListener() {
    emailTextController.addListener(() {
      isValidInputSignUp.value = checkValidInputSignUp();
      isValidInputLoginWithEmail.value = checkValidInputSignInWithEmail();
    });
    userTextController.addListener(() {});
    passwordTextController.addListener(() {
      isValidInputSignUp.value = checkValidInputSignUp();
      isValidInputLoginWithEmail.value = checkValidInputSignInWithEmail();
    });
    rePasswordTextController.addListener(() {
      isValidInputSignUp.value = checkValidInputSignUp();
    });
  }

  bool checkValidInputSignUp() =>
      checkValidInputSignInWithEmail() &&
      rePasswordTextController.text.isNotEmpty;
  bool checkValidInputSignInWithEmail() =>
      emailTextController.text.isNotEmpty &&
      passwordTextController.text.isNotEmpty;
}
