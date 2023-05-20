import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/data/enums/gender_enum.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_controller.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpSex extends StatefulWidget {
  @override
  _SignUpSexState createState() => _SignUpSexState();
}

class _SignUpSexState extends State<SignUpSex>
    with AutomaticKeepAliveClientMixin<SignUpSex> {
  @override
  bool get wantKeepAlive => true;
  final SignUpController controller = Get.find<SignUpController>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return InkWell(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(SpaceUtils.spaceLarge),
                child: Text(
                  'selectSex'.tr,
                  style: TextStyle(
                      color: ColorUtils.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          return ButtonWidget(
                              onPress: () {
                                GenderType selectedEnum = GenderType.male;
                                controller.updateGender(selectedEnum);
                              },
                              color: controller.gender.value != GenderType.male
                                  ? Colors.white
                                  : ColorUtils.primaryColor,
                              labelColor:
                                  controller.gender.value == GenderType.male
                                      ? Colors.white
                                      : ColorUtils.primaryColor,
                              label: 'male'.tr,
                              icon: controller.gender.value == GenderType.male
                                  ? Icon(Icons.check,
                                      size: 24, color: Colors.white)
                                  : null);
                        }),
                      ))
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() {
                          return ButtonWidget(
                            onPress: () {
                              GenderType selectedEnum = GenderType.female;
                              controller.updateGender(selectedEnum);
                            },
                            color: controller.gender.value != GenderType.female
                                ? Colors.white
                                : ColorUtils.primaryColor,
                            labelColor:
                                controller.gender.value == GenderType.female
                                    ? Colors.white
                                    : ColorUtils.primaryColor,
                            label: 'female'.tr,
                            icon: controller.gender.value == GenderType.female
                                ? Icon(Icons.check,
                                    size: 24, color: Colors.white)
                                : null,
                          );
                        }),
                      ))
                    ],
                  )
                ]))
          ],
        ),
      ),
    );
  }
}
