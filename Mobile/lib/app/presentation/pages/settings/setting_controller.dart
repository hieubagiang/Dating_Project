import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/configs/configurations.dart';
import 'package:dating_app/app/data/enums/interested_gender_enum.dart';
import 'package:dating_app/app/data/models/user_model/filter_user_model/age_range_model.dart';
import 'package:dating_app/app/data/models/user_model/filter_user_model/filter_user_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/utils/index.dart';
import '../../../data/models/subscription_package_model/subscription_package_model.dart';
import '../../../widgets/loader_widget/loader_controller.dart';
import '../../../widgets/new_dialog/custom_dialog.dart';

class SettingsController extends BaseController {
  RxDouble distance = 50.0.obs;
  Rx<RangeValues> rangeValues = AgeRangeModel().toRangeValue().obs;
  Rx<UserModel?> currentUser = Rx(null);
  final repository = Get.find<UserRepository>();
  RxString address = ''.obs;
  final debouncer = Debouncer(delay: Duration(milliseconds: 500));

  final commonController = Get.find<CommonController>();
  RxList<SubscriptionPackageModel> subscriptionPackages = RxList([]);

  RxBool isShared = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    currentUser.bindStream(repository.listenUser());

    currentUser.listen((user) async {
      address.value = user?.location?.address ?? '';
      address.value = user?.location?.address ?? '';
      distance.value = user?.feedFilter?.distance ?? 0;
      rangeValues.value =
          currentUser.value?.feedFilter?.ageRange?.toRangeValue() ??
              AgeRangeModel().toRangeValue();
      subscriptionPackages.value = await repository.getSubscriptionPackages();
    });

    rangeValues.stream.listen((ageRange) {
      onChangeFilter(
        currentUser.value!.feedFilter!.copyWith(
          ageRange: AgeRangeModel.fromRangeValues(
            ageRange,
          ),
        ),
      );
    });
    distance.stream.listen((distance) {
      onChangeFilter(
        currentUser.value!.feedFilter!.copyWith(
          distance: distance,
        ),
      );
    });
  }

  void onChangeFilter(FeedFilterModel model) {
    if (currentUser.value?.feedFilter == model) return;
    debouncer.call(() async {
      await repository.updateInteractedFilter(model);
    });
  }

  void onChangeGender(InterestedGenderType genderType) {
    onChangeFilter(currentUser.value!.feedFilter!
        .copyWith(interestedInGender: genderType.id));
  }

  Future<void> onTapReward() async {
    // if (MainController.isDemoMode) {
    //   FunctionUtils.showToast('coming_soon'.tr);
    //   return;
    // }
    await Share.share(
        'Dating là 1 ứng dụng hẹn hò tuyệt vời, tải về ngay: ${Configurations.webHomePage}');
    isShared.value = true;
    await repository.updateUser(currentUser.value!.addPremium(7));
  }

  @override
  void onResumed() {
    super.onResumed();
    FunctionUtils.logWhenDebug(this, 'resume');
    if (isShared.isTrue) {
      commonController.showDialog(
          dialog: CustomDialog(
        title: 'Thông báo',
        description:
            'Chia sẻ thành công, tài khoản của bạn được thêm 7 ngày premium'.tr,
        onAccept: () {
          Get.back();
        },
      ));
      isShared.value = false;
    }
  }

  @override
  void onPaused() {
    super.onResumed();
    FunctionUtils.logWhenDebug(this, 'onPaused');
  }
}
