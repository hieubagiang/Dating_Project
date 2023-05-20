import 'dart:io';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/enums/gender_enum.dart';
import 'package:dating_app/app/data/models/user_model/hobby_model/hobby_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:flutter/material.dart';

import '../../../common/utils/index.dart';

class EditController extends BaseController {
  RxString avatarUrl = RxString('');
  StorageRepository storageRepository = Get.find<StorageRepository>();
  UserRepository userRepository = Get.find<UserRepository>();
  RxList<HobbyModel> hobbyList = RxList.empty();
  RxList<HobbyModel> selectedHobbyList = RxList.empty();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  RxList<File> photoList = List<File>.generate(9, (file) => File('')).obs;
  RxList<String> photoListUrl = <String>[].obs;
  Rx<GenderType> gender = GenderType.male.obs;
  Rx<DateTime?> birthDate = Rx(null);
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;

  @override
  Future<void> onInit() async {
    super.onInit();
    // photoList.value =
    //     List<File>.filled(9, currentUser.value?.photoList?.map((e) => e.url));
    photoListUrl.value =
        currentUser.value!.photoList!.map((e) => e.url).toList();
    descriptionTextController.text = currentUser.value?.description ?? '';
    print('${currentUser.value?.id}');
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    hobbyList.value = await userRepository.getHobbyList();
  }

  Future<void> addImage(File image, int index, fileName) async {
    photoList[index] = image;
    await storageRepository.uploadFile(image, fileName: fileName);
    final photos = await storageRepository.getUserPhotos();
    userRepository.updateUser(currentUser.value!.copyWith(photoList: photos));
  }

  Future<void> getImageAndCrop(int index) async {}

  void onChangeGender(GenderType e) {
    userRepository.updateUser(currentUser.value!.copyWith(gender: e));
  }

  void onSubmitted() {
    userRepository.updateUser(currentUser.value!
        .copyWith(description: descriptionTextController.text));
    FunctionUtils.showToast('Cập nhật hồ sơ thành công',
        backgroundColor: ColorUtils.primaryColor,
        textColor: ColorUtils.secondaryColor);
  }

  void onTapHobby(HobbyModel model, bool isSelected) {
    if (isSelected) {
      selectedHobbyList.add(model);
    } else {
      selectedHobbyList.remove(model);
    }
    userRepository
        .updateUser(currentUser.value!.copyWith(hobbies: selectedHobbyList));
  }
}
