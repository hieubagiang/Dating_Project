import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../widgets/widgets_common.dart';
import '../sign_in/widgets/email_input_form.dart';
import 'phone_authentication_controller.dart';

class PhoneAuthenticationScreen
    extends BaseView<PhoneAuthenticationController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBanner(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                              children: [_buildPhoneInputWidget()],
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

  Widget _buildBanner() {
    return Stack(
      children: [
        Positioned(
            top: 25.h,
            left: 12.w,
            child: IconButton(
                onPressed: () => Get.back(), icon: Icon(Icons.arrow_back))),
        Container(
          width: double.infinity,
          height: 390.h,
          child: Stack(
            children: [
              Positioned(
                  left: 64.w,
                  top: 90.w,
                  child: Image.asset(
                    ImageUtils.heart,
                    width: 64.w,
                  )),
              Positioned(
                  right: 0,
                  child: SvgPicture.asset(
                    ImageUtils.coupleImage,
                    height: 390.h,
                  )),
              Positioned(
                  left: 28.h,
                  top: 230.h,
                  child: SizedBox(
                    width: 1.sw / 2,
                    child: Text(
                      'login_to_a_lovely_life'.tr,
                      style: TextStyle(
                          fontSize: 36.sp,
                          fontWeight: FontWeight.bold,
                          color: ColorUtils.primaryTextColor),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInputWidget() {
    return Column(
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
    );
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
