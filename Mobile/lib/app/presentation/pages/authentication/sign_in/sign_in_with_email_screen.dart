import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/auth_method_enum.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/widgets/email_input_form.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../widgets/banner.dart';
import 'sign_in_controller.dart';

class SignInWithEmailScreen extends BaseView<SignInController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceMedium),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      const BannerWidget(),
                      Positioned(
                        top: 24.h,
                        left: 0,
                        child: IconButton(
                          onPressed: () {
                            controller.onTapBack();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: ColorUtils.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Form(
                            key: controller.formKey,
                            autovalidateMode: controller.isAutoValidate.isTrue
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _buildPhoneInputWidget(),
                                (controller.isSignUpWithEmail.isTrue)
                                    ? _buildSignUpEmail()
                                    : _buildEmailInputWidget(),
                              ],
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneInputWidget() {
    return Obx(() {
      return (controller.authMethod.value == AuthMethod.phone)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'enter_your_mobile_number'.tr,
                  style: StyleUtils.style16Medium
                      .copyWith(color: ColorUtils.primaryTextColor),
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                BaseInputForm(
                  textController: controller.phoneTextController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(9)],
                  validator: Validate.phoneValidator,
                  prefixWidget: Padding(
                    padding: EdgeInsets.only(right: SpaceUtils.spaceSmall / 4),
                    child: Text(
                      '+84',
                      style: StyleUtils.style20Medium,
                    ),
                  ),
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                _buildSubmitButton(
                    label: 'continue'.tr,
                    onPressed: () {
                      controller.signInWithPhone();
                    }),
              ],
            )
          : const SizedBox();
    });
  }

  Widget _buildEmailInputWidget() {
    return Obx(() {
      return (controller.authMethod.value == AuthMethod.email)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'username_emailLabel'.tr,
                  style: StyleUtils.style16Medium
                      .copyWith(color: ColorUtils.primaryColor),
                ),
                SizedBox(height: SpaceUtils.spaceSmaller),
                BaseInputForm(
                  textController: controller.emailTextController,
                  validator: Validate.usernameValidator,
                  // hintText: 'emailHintText'.tr,
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                if (controller.isForgotPassword.isFalse) ...[
                  Text(
                    'passwordLabel'.tr,
                    style: StyleUtils.style16Medium
                        .copyWith(color: ColorUtils.primaryColor),
                  ),
                  SizedBox(height: SpaceUtils.spaceSmaller),
                  BaseInputForm(
                    textController: controller.passwordTextController,
                    validator: Validate.passwordValidator,
                    isObscureText: true,
                    // hintText: 'passwordHintText'.tr,
                  ),
                  SizedBox(height: SpaceUtils.spaceSmall),
                  Obx(() {
                    return _buildSubmitButton(
                        label: 'signIn'.tr,
                        onPressed: controller.loginWithEmail,
                        isActive: controller.isValidInputLoginWithEmail.isTrue);
                  }),
                ],
                if (controller.isForgotPassword.isTrue)
                  _buildSubmitButton(
                      label: 'reset_password'.tr,
                      onPressed: controller.resetPassword),
                SizedBox(height: SpaceUtils.spaceMedium),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.onTapSignUpWithEmailText();
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
                        child: RichText(
                          text: TextSpan(
                              text: 'dontHaveAccount'.tr,
                              style: StyleUtils.style14Normal.copyWith(
                                  color: ColorUtils.primaryTextColor
                                      .withOpacity(0.5)),
                              children: [
                                TextSpan(
                                  text: 'signUp'.tr,
                                  style: StyleUtils.style14Normal
                                      .copyWith(color: ColorUtils.primaryColor),
                                )
                              ]),
                        ),
                      ),
                    ),
                    controller.isForgotPassword.isFalse
                        ? Flexible(
                            child: InkWell(
                                onTap: () {
                                  controller.isForgotPassword.value = true;
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.h),
                                  child: Text('forgotPassword'.tr,
                                      style: StyleUtils.style14Normal.copyWith(
                                          color: ColorUtils.primaryColor)),
                                )),
                          )
                        : InkWell(
                            onTap: () {
                              controller.isForgotPassword.value = false;
                            },
                            child: Text('signIn'.tr,
                                style: StyleUtils.style16Normal
                                    .copyWith(color: ColorUtils.primaryColor)))
                  ],
                )
              ],
            )
          : const SizedBox();
    });
  }

  Widget _buildSignUpEmail() {
    return Obx(() {
      return (controller.authMethod.value == AuthMethod.email)
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'emailLabel'.tr,
                  style: StyleUtils.style16Medium
                      .copyWith(color: ColorUtils.primaryColor),
                ),
                SizedBox(height: SpaceUtils.spaceSmaller),
                BaseInputForm(
                  textController: controller.emailTextController,
                  validator: controller.isSignUpWithEmail.isTrue
                      ? Validate.emailValidator
                      : Validate.usernameValidator,
                  // hintText: 'emailHintText'.tr,
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                Text(
                  'passwordLabel'.tr,
                  style: StyleUtils.style16Medium
                      .copyWith(color: ColorUtils.primaryColor),
                ),
                SizedBox(height: SpaceUtils.spaceSmaller),
                BaseInputForm(
                  textController: controller.passwordTextController,
                  validator: Validate.passwordValidator,
                  isObscureText: true,
                  // hintText: 'passwordHintText'.tr,
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                Text(
                  'confirmPasswordLabel'.tr,
                  style: StyleUtils.style16Medium
                      .copyWith(color: ColorUtils.primaryColor),
                ),
                SizedBox(height: SpaceUtils.spaceSmaller),
                BaseInputForm(
                  textController: controller.rePasswordTextController,
                  validator: Validate.passwordValidator,
                  isObscureText: true,
                  // hintText: 'passwordHintText'.tr,
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                Obx(() {
                  return _buildSubmitButton(
                      label: 'signUp'.tr,
                      onPressed: controller.signUpWithEmail,
                      isActive: controller.isValidInputSignUp.isTrue);
                }),
                SizedBox(height: SpaceUtils.spaceSmall),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => controller.onTapSignInWithEmailText(),
                      child: RichText(
                        text: TextSpan(
                            text: 'haveAnAccountText'.tr,
                            style: StyleUtils.style16Normal.copyWith(
                                color: ColorUtils.primaryTextColor
                                    .withOpacity(0.5)),
                            children: [
                              TextSpan(
                                text: 'signIn'.tr,
                                style: StyleUtils.style16Normal
                                    .copyWith(color: ColorUtils.primaryColor),
                              )
                            ]),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h)
              ],
            )
          : const SizedBox();
    });
  }

  ButtonWidget _buildSubmitButton(
      {required String label,
      required Function() onPressed,
      bool isActive = true}) {
    return ButtonWidget(
        height: 50.h,
        onPress: isActive ? onPressed : null,
        label: label,
        color: isActive ? ColorUtils.primaryColor : ColorUtils.lightGreyColor,
        padding: EdgeInsets.symmetric(vertical: SpaceUtils.spaceSmall));
  }
}
