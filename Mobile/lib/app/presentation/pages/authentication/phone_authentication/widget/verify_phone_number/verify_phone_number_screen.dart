import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';

import '../../../../../../common/utils/layout_utils.dart';
import 'verify_phone_number_controller.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  void _showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<VerifyPhoneNumberController>();

    return SafeArea(
      child: FirebasePhoneAuthHandler(
        phoneNumber: controller.phoneNumber.value,
        onLoginSuccess: (userCredential, autoVerified) async {
          _showSnackBar(
            context,
            'phone_number_verified_successfully'.tr,
          );

          debugPrint(
            autoVerified
                ? "OTP was fetched automatically"
                : "OTP was verified manually",
          );

          debugPrint("Login Success UID: ${userCredential.user?.uid}");
        },
        onLoginFailed: (authException,e) {
          _showSnackBar(
            context,
            'Something went wrong (${authException.message})',
          );

          debugPrint(authException.message);
          // handle error further if needed
        },
        builder: (context, controllerAuth) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: ColorUtils.primaryColor,
              title: Text("verify_phone_number".tr),
              actions: [
                if (controllerAuth.codeSent)
                  ElevatedButton(
                    child: Text(
                      controllerAuth.isOtpExpired
                          ? "${controllerAuth.otpExpirationTimeLeft.inSeconds}s"
                          : "resend".tr,
                      style: TextStyle(
                        color: ColorUtils.whiteColor,
                        fontSize: 18.sp,
                      ),
                    ),
                    onPressed: controllerAuth.isOtpExpired
                        ? null
                        : () async => await controllerAuth.sendOTP(),
                  ),
                const SizedBox(width: 5),
              ],
            ),
            body: controllerAuth.codeSent
                ? ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      Text(
                        'verify_phone_number_description'.tr +
                            " ${controller.phoneNumber}",
                        style: TextStyle(
                          fontSize: 24.sp,
                        ),
                      ),
                      SizedBox(height: SpaceUtils.spaceSmall),
                      const Divider(),
                      AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        height: controllerAuth.isOtpExpired ? null : 0,
                        child: Column(
                          children: [
                            CircularProgressIndicator.adaptive(),
                            SizedBox(height: 50),
                            Text(
                              "listening_for_otp".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 25.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: SpaceUtils.spaceSmall),
                            Text("or".tr, textAlign: TextAlign.center),
                            SizedBox(height: SpaceUtils.spaceSmall),
                          ],
                        ),
                      ),
                      Text(
                        "enter_otp".tr,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Center(
                        child: VerificationCode(
                          textStyle: TextStyle(
                              fontSize: 20.sp, color: ColorUtils.primaryColor),
                          keyboardType: TextInputType.number,
                          underlineColor: ColorUtils.primaryColor,
                          // If this is null it will use primaryColor: Colors.red from Theme
                          length: 6,
                          digitsOnly: true,
                          cursorColor: ColorUtils.primaryColor,
                          // If this is null it will usedefault to the ambient
                          // clearAll is NOT required, you can delete it
                          // takes any widget, so you can implement your design
                          onCompleted: (String value) async {
                            controller.enteredOTP?.value = value;
                            if (controller.enteredOTP?.value.length == 6) {
                              final isValidOTP = await controllerAuth.verifyOtp(
                                controller.enteredOTP!.value,
                              );
                              // Incorrect OTP
                              if (!isValidOTP) {
                                _showSnackBar(
                                  context,
                                  'please_enter_the_correct_otp_sent_to'.tr +
                                      " ${controller.phoneNumber}",
                                );
                              }
                            }
                          },
                          onEditing: (bool value) {},
                        ),
                      ),
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      SizedBox(height: 50.h),
                      Center(
                        child: Text(
                          "sending_otp".tr,
                          style: TextStyle(fontSize: 25.sp),
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
