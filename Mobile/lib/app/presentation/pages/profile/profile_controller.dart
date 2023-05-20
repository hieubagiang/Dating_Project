import 'dart:io';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/utils/file_utils.dart';
import 'package:dating_app/app/common/utils/functions.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';

class ProfileController extends BaseController {
  RxString avatarUrl = RxString('');
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  final commonController = Get.find<CommonController>();
  StorageRepository storageRepository = Get.put(StorageRepository());
  Rx<File?> avatar = Rx(null);
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> addAvatar() async {
    commonController.startLoading();
    File? image = await FileUtils.getImageAndCrop();
    avatar.value = image;
    commonController.stopLoading();

    if (image != null) {
      final imageUrl =
          await storageRepository.uploadFile(image, fileName: 'avatar');
      avatarUrl.value = imageUrl.url;
      FunctionUtils.logWhenDebug(this, avatarUrl.value);
      await Get.find<UserRepository>()
          .updateUser(currentUser.value!.copyWith(avatarUrl: avatarUrl.value));
    }
  }
}
