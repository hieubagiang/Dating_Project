import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_controller.dart';
import 'package:dating_app/app/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpIntroduce extends StatefulWidget {
  @override
  _SignUpIntroduceState createState() => _SignUpIntroduceState();
}

class _SignUpIntroduceState extends State<SignUpIntroduce>
    with AutomaticKeepAliveClientMixin<SignUpIntroduce> {
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
                  'typeYourInformation'.tr,
                  style: TextStyle(
                      color: ColorUtils.primaryColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
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
            SizedBox(height: 50.h),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Container(
                height: 150,
                child: TextFormField(
                  controller: controller.descriptionTextController,
                  keyboardType: TextInputType.multiline,
                  maxLines: 10,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(0, 0, 0, 0.4), width: 1),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      labelText: 'introduce'.tr,
                      labelStyle: TextStyle(
                          color: ColorUtils.primaryColor2, fontSize: 18),
                      hintText: 'introduce2'.tr),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
