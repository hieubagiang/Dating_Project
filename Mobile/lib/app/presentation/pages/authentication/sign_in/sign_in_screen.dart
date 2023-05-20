import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/configs/configurations.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/auth_method_enum.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/banner.dart';
import 'sign_in_controller.dart';

class SignInScreen extends BaseView<SignInController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    const BannerWidget(),
                    Positioned(
                        top: 24.h,
                        left: 12.w,
                        child: IconButton(
                            onPressed: () => Get.back(),
                            icon: Icon(Icons.arrow_back))),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SpaceUtils.spaceLarge),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SpaceUtils.spaceSmall),
                      _buildSignInWithEmailButton(),
                      _buildSignInWithPhoneButton(),
                      SizedBox(height: SpaceUtils.spaceSmall / 2),
                      _methodDivider(),
                      SizedBox(height: SpaceUtils.spaceSmall),
                      Row(
                        children: [
                          Expanded(
                            child: _buildGoogleSignIn(),
                          ),
                          SizedBox(width: SpaceUtils.spaceMedium),
                          Expanded(
                            child: _buildFacebookSignIn(),
                          ),
                        ],
                      ),
                      _spaceMini(),
                      ButtonWidget(
                        label: 'tryLabel'.tr,
                        height: 50.h,
                        labelColor: ColorUtils.primaryColor,
                        color: ColorUtils.whiteColor,
                        onPress: () {
                          controller.continueWithoutSignIn();
                        },
                      ),
                      _spaceMini(),
                      SizedBox(height: SpaceUtils.spaceSmall / 2),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.onTapSignUpWithEmailText();
                              Get.toNamed(RouteList.signInWithEmail);
                            },
                            child: RichText(
                              text: TextSpan(
                                  text: 'dontHaveAccount'.tr,
                                  style: StyleUtils.style16Normal.copyWith(
                                      color: ColorUtils.primaryTextColor
                                          .withOpacity(0.5)),
                                  children: [
                                    TextSpan(
                                      text: 'signUp'.tr,
                                      style: StyleUtils.style16Normal.copyWith(
                                          color: ColorUtils.primaryColor),
                                    )
                                  ]),
                            ),
                          ),
                          /*Text('forgotPassword'.tr, style: StyleUtils.style16Normal.copyWith(color: ColorUtils.primaryColor))*/
                        ],
                      ),
                      SizedBox(height: SpaceUtils.spaceSmall),
                      _buildRule(),
                      SizedBox(height: SpaceUtils.spaceSmall / 2),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ButtonWidget _buildFacebookSignIn() {
    return ButtonWidget(
      //      label: 'signInWithFacebookLabel'.tr,
      color: ColorUtils.facebookColor,
      children: SvgPicture.asset(
        IconUtils.iconFacebook,
        color: ColorUtils.whiteColor,
        width: SizeUtils.iconSize,
      ),
      onPress: controller.signInWithFacebook,
    );
  }

  Widget _buildGoogleSignIn() {
    return ButtonWidget(
      //  label: 'signInWithGoogleLabel'.tr,
      color: ColorUtils.whiteColor,
      children: SvgPicture.asset(
        IconUtils.iconGoogle,
        width: SizeUtils.iconSize,
      ),
      onPress: () {
        controller.signInWithGoogle();
      },
    );
  }

  Widget _buildSignInWithPhoneButton() {
    return Obx(() {
      return (controller.authMethod.value == AuthMethod.phone)
          ? SizedBox()
          : Padding(
              padding: EdgeInsets.only(bottom: SpaceUtils.spaceSmall),
              child: ButtonWidget(
                height: 50.h,
                label: 'signInWithPhoneLabel'.tr,
                labelColor: ColorUtils.whiteColor,
                color: ColorUtils.primaryColor2,
                onPress: () {
                  //controller.changeAuthMethod(AuthMethod.phone);
                  controller.signInWithPhone();
                },
              ),
            );
    });
  }

  Widget _buildSignInWithEmailButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: SpaceUtils.spaceSmall),
      child: ButtonWidget(
        padding: EdgeInsets.symmetric(vertical: SpaceUtils.spaceSmall),
        height: 50.h,
        label: 'signInWithEmailLabel'.tr,
        labelColor: ColorUtils.redColor,
        color: ColorUtils.whiteColor,
        onPress: () => Get.toNamed(RouteList.signInWithEmail),
      ),
    );
  }

  Center _buildRule() {
    return Center(
      child: InkWell(
        onTap: () {
          FunctionUtils.launchURL(Configurations.policyLink);
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(color: ColorUtils.primaryTextColor),
            children: [
              TextSpan(text: "continue-login".tr),
              TextSpan(
                text: 'Term & policies'.tr,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.primaryTextColor,
                    decoration: TextDecoration.underline),
              ),
              TextSpan(text: "of_us".tr),
            ],
          ),
        ),
      ),
    );
  }

  Row _methodDivider() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            color: ColorUtils.primaryTextColor.withOpacity(0.3),
            height: 1,
          ),
        ),
        SizedBox(width: SpaceUtils.spaceMedium),
        Text('orSignUpWith'.tr,
            style: TextStyle(
                color: ColorUtils.primaryTextColor,
                fontWeight: FontWeight.w300)),
        SizedBox(width: SpaceUtils.spaceMedium),
        Expanded(
          child: Container(
            color: ColorUtils.primaryTextColor.withOpacity(0.3),
            height: 1,
          ),
        ),
      ],
    );
  }

  SizedBox _spaceMini() {
    return SizedBox(
      height: SpaceUtils.spaceSmall,
    );
  }
}
