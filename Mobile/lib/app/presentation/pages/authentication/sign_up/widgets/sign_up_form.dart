import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_controller.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:dating_app/app/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../common/configs/configurations.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with AutomaticKeepAliveClientMixin<SignUpForm> {
  @override
  bool get wantKeepAlive => true;
  final SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
      padding: EdgeInsets.all(SpaceUtils.spaceMedium),
      child: Container(
        height: 1.sh,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(SpaceUtils.spaceMediumLarge),
                child: Text(
                  'typeYourInformation'.tr,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.primaryColor,
                  ),
                ),
              ),
            ),
            Center(
              child: Obx(() {
                return CustomAvatar(
                    isCircleAvatar: false,
                    sizeAvatar: 140.w,
                    avatarUrl: controller.avatarUrl.value,
                    file: controller.avatar.value,
                    padding: 12.w,
                    borderRadius: 20.w,
                    showCameraIcon: true,
                    onTap: controller.addAvatar);
              }),
            ),
            Form(
              key: controller.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: SpaceUtils.spaceMedium),
                  _buildInputField(
                      hintText: ''.tr,
                      labelText: 'userLabel'.tr,
                      validator: Validate.nameValidator,
                      textController: controller.usernameTextController),
                  SizedBox(height: SpaceUtils.spaceMedium),
                  _buildInputField(
                      hintText: ''.tr,
                      labelText: 'nameFieldLabel'.tr,
                      validator: Validate.nameValidator,
                      textController: controller.nameTextController),
                  SizedBox(height: SpaceUtils.spaceMedium),
                ],
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 12.0),
            //   child: Row(
            //     children: [
            //       Icon(
            //         Icons.wc,
            //         color: Colors.grey,
            //       ),
            //       _buildRadioGroupGender(),
            //     ],
            //   ),
            // ),
            ButtonWidget(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              onPress: () => _selectBirthday(),
              label: DateTimeUtils.getStringDate(controller.birthDate.value,
                      pattern: Pattern.ddMMyyyy_vi) ??
                  'selectBirthdayLabel'.tr,
              labelColor: Color.fromRGBO(233, 64, 87, 1),
              // children: Text(DateTimeUtils.getStringDate(controller.birthDate.value, pattern: Pattern.ddMMyyyy_vi) ?? 'selectBirthdayLabel'.tr, style: TextStyle(color: Color.fromRGBO(233, 64, 87, 1), fontSize: 16)),

              color: ColorUtils.lightPrimary,
              icon: SvgPicture.asset(
                'assets/svg/ic_calendar.svg',
                width: SizeUtils.iconSize,
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Obx(() {
                  return Checkbox(
                      value: controller.isAgreeTerm.value,
                      activeColor: ColorUtils.primaryColor,
                      onChanged: (value) {
                        controller.isAgreeTerm.value = value!;
                      });
                }),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.isAgreeTerm.value =
                            !controller.isAgreeTerm.value;
                      });
                    },
                    child: Text(
                      'iAgreeTo'.tr,
                      style: TextStyle(fontSize: 16),
                    )),
                GestureDetector(
                    onTap: () {
                      FunctionUtils.launchURL(Configurations.policyLink);
                    },
                    child: Text('termOfService'.tr,
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorUtils.primaryColor,
                            fontWeight: FontWeight.bold)))
              ],
            )
          ],
        ),
      ),
    );
  }

  Container _buildInputField(
      {required TextEditingController textController,
      required String labelText,
      required String hintText,
      FormFieldValidator<String>? validator}) {
    return Container(
      alignment: Alignment.center,
      child: TextFormField(
        controller: textController,
        validator: validator,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
            borderRadius: BorderRadius.circular(25.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(25.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(25.0),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          labelText: labelText,
          labelStyle:
              TextStyle(color: ColorUtils.primaryColor, fontSize: 18.sp),
          hintText: hintText,
        ),
      ),
    );
  }

  Future<void> _selectBirthday() async {
    final DateTime? _pickedDate = await showDatePicker(
        context: context,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: ColorUtils.primaryColor,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: Colors.red, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        initialDate: DateTime(DateTime.now().year - 22, DateTime.now().month),
        firstDate: DateTime(DateTime.now().year - 60, DateTime.now().month),
        lastDate: DateTime(DateTime.now().year - 18, DateTime.now().month));
    controller.updateBirthDate(_pickedDate);
    FocusScope.of(context).requestFocus(FocusNode());
  }
}
