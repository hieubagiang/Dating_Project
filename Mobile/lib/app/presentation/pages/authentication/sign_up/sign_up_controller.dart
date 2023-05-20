import 'dart:convert';
import 'dart:io';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/gender_enum.dart';
import 'package:dating_app/app/data/models/user_model/hobby_model/hobby_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import '../../../../data/models/user_model/filter_user_model/age_range_model.dart';
import '../../../../data/models/user_model/filter_user_model/filter_user_model.dart';
import '../../../../widgets/loader_widget/loader_controller.dart';
import '../../../../widgets/new_dialog/custom_dialog.dart';

class SignUpController extends BaseController {
  RxString avatarUrl = RxString('');
  Rx<File?> avatar = Rx(null);
  Rx<GenderType> gender = GenderType.male.obs;
  Rx<DateTime?> birthDate = Rx(null);
  RxBool isAgreeTerm = RxBool(false);
  RxList<File> photoList = <File>[].obs;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  RxList<HobbyModel> hobbies = RxList.empty();
  RxList<HobbyModel> selectedHobbies = RxList.empty();
  StorageRepository storageRepository = Get.find<StorageRepository>();
  UserRepository userRepository = Get.find<UserRepository>();
  final commonController = Get.find<CommonController>();
  GlobalKey formKey = GlobalKey();

  @override
  Future<void> onInit() async {
    super.onInit();
    userRepository.checkServerInitData();
    hobbies.value = await userRepository.getHobbyList();
    usernameTextController.text =
        userRepository.getFireBaseUser()?.email?.split("@").first ?? '';
  }

  void updateGender(GenderType? gender) {
    this.gender.value = gender ?? this.gender.value;
    print('${this.gender.value}');
  }

  void updateBirthDate(DateTime? birthDate) {
    this.birthDate.value = birthDate ?? this.birthDate.value;
    print('${this.birthDate.value}');
  }

  Future<void> addImage(File image, fileName) async {
    photoList.add(image);
    FunctionUtils.logWhenDebug(this, photoList.first.path);
    await storageRepository.uploadFile(image, fileName: fileName);
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
    }
  }

  void onTapInterest({required HobbyModel model, required bool isSelected}) {
    if (isSelected) {
      selectedHobbies.add(model);
    } else {
      selectedHobbies.remove(model);
    }
  }

  bool isSelected(HobbyModel model) => selectedHobbies.contains(model);

  Future<void> submitSignUp() async {
    commonController.startLoading();
    final photoList = await storageRepository.getUserPhotos();
    FunctionUtils.logWhenDebug(this, '$photoList');
    var user = UserModel.init().copyWith(
      id: userRepository.currentUserId!,
      name: nameTextController.text,
      username: usernameTextController.text,
      email: userRepository.getFireBaseUser()?.email,
      description: descriptionTextController.text,
      gender: gender.value,
      birthday: birthDate.value!,
      avatarUrl: avatarUrl.value,
      photoList: photoList,
      hobbies: selectedHobbies,
      feedFilter: FeedFilterModel(
          distance: 10,
          interestedInGender: gender.value.interestedInGender.id,
          ageRange: AgeRangeModel()),
    );
    FunctionUtils.logWhenDebug(this, jsonEncode(user.toJson()));
    await userRepository.profileSetup(user);
    commonController.stopLoading();
    commonController.showDialog(
        dialog: CustomDialog(
      description: 'Tạo hồ sơ thành công!',
      acceptText: 'Khám phá ngay',
      onAccept: () {
        Get.offAllNamed(RouteList.main);
      },
    ));
  }
}
