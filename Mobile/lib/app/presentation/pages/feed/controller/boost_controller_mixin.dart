import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/models/boost/boost_model.dart';
import 'package:dating_app/app/data/repositories/boost_repository.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:dating_app/app/widgets/new_dialog/alert_dialog.dart';
import 'package:dating_app/app/widgets/new_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';

import '../../main/main_controller.dart';
import '../../premium/premium_controller.dart';

mixin BoostController {
  final BoostRepository _boostRepository = Get.find<BoostRepositoryImpl>();
  CommonController commonController = Get.find<CommonController>();
  Rx<BoostModel?> boostProfileStatus = Rx(null);

  void initBoostController() {
    boostProfileStatus
        .bindStream(_boostRepository.listenToUserBoostStatusRealTime());
    _boostRepository;
  }

  void boost() async {
    // if (MainController.isDemoMode) {
    //   FunctionUtils.showToast('coming_soon'.tr);
    //   return;
    // }
    final mainController = Get.find<MainController>();
    if (mainController.isGuestMode) {
      mainController.logOutGuest();
      return;
    }

    bool isPremiumUser =
        Get.find<MainController>().currentUser.value?.isPremiumUser ?? false;
    if (!isPremiumUser) {
      Get.dialog(AdsPremiumDialog());
      return;
    }

    if (_isCanBoost()) {
      bool? isBoostSuccessful = await commonController.showDialog(
        dialog: ConfirmDialog(
          description: 'boost_description'.tr,
          context: Get.context!,
          onConfirmed: () async {
            await _boostRepository.boostProfile();
            Get.back(result: true);
          },
        ),
      );
      if (isBoostSuccessful != null) {
        commonController.showDialog(
          dialog: AlertDialogCustom(
            description: isBoostSuccessful
                ? 'boost_success_description'.tr
                : 'boost_failure_description'.tr,
            context: Get.context!,
            onTap: () {
              Get.back();
            },
          ),
        );
      }
    } else {
      commonController.showDialog(
        dialog: AlertDialogCustom(
          bodyWidget: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'boosting'.tr,
                style: StyleUtils.style16Normal,
              ),
              SizedBox(
                width: SpaceUtils.spaceSmall,
              ),
              CountdownTimer(
                endTime:
                    boostProfileStatus.value!.expireAt!.millisecondsSinceEpoch,
              ),
            ],
          ),
          context: Get.context!,
          onTap: () {
            Get.back();
          },
        ),
      );
    }
  }

  bool _isCanBoost() {
    return boostProfileStatus.value == null ||
        (boostProfileStatus.value != null &&
            (DateTime.now().compareTo(boostProfileStatus.value!.expireAt!)) >
                0);
  }
}

class AdsPremiumDialog extends StatelessWidget {
  const AdsPremiumDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(SpaceUtils.spaceSmall),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: SpaceUtils.spaceMedium),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('Nâng cấp lên premium để:'.tr,
                            textAlign: TextAlign.center,
                            style: StyleUtils.style20Normal
                                .copyWith(color: ColorUtils.primaryColor)),
                      ),
                    ],
                  ),
                  SizedBox(height: SpaceUtils.spaceSmall),
                  _buildFeatureText(
                      '- Đưa trang cá nhân lên top lựa chọn, tiếp cận nhiều người hơn'),
                  _buildFeatureText(
                      '- Bỏ lỡ một người, đừng lo đã có quay lại'),
                  _buildFeatureText('- Mở khoá giới hạn tương tác mỗi ngày'),
                  _buildFeatureText('- Nhắn tin ngay cả khi chưa tương hợp'),
                  _buildFeatureText(
                      '- Xem ai đã thích bạn, bạn đã tương tác với ai'),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.volunteer_activism,
                          size: 100.sp, color: Color.fromRGBO(227, 164, 65, 1)),
                      SizedBox(height: SpaceUtils.spaceSmall),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Text('easy-payment'.tr,
                            style: StyleUtils.style20Normal,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: SpaceUtils.spaceSmaller,
                    horizontal: SpaceUtils.spaceLarge),
                child: ButtonWidget(
                    color: Color.fromRGBO(227, 164, 65, 1),
                    label: 'subscription-now'.tr,
                    onPress: () =>
                        Get.find<PremiumController>().showDialogPremium()),
              )
            ]),
      ),
    );
  }

  Row _buildFeatureText(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Text(text,
              textAlign: TextAlign.left, style: StyleUtils.style16Italic),
        ),
      ],
    );
  }
}
