import 'dart:math';

import 'package:dating_app/app/common/extension/extensions.dart';
import 'package:dating_app/app/data/enums/gender_enum.dart';
import 'package:dating_app/app/data/models/fake_model/boy_generator.dart';
import 'package:dating_app/app/data/models/fake_model/girl_generator.dart';
import 'package:dating_app/app/data/models/user_model/photo_model/photo_model.dart';
import 'package:dating_app/app/data/provider/fake_user_api/random_user_me.dart';

import '../../../common/base/base_controller.dart';
import '../../../data/mock_data/mock_data.dart';
import '../../../data/models/fake_model/fake_user_model.dart';
import '../../../data/models/user_model/filter_user_model/age_range_model.dart';
import '../../../data/models/user_model/filter_user_model/filter_user_model.dart';
import '../../../data/provider/user_api.dart';

class AdminController extends BaseController {
  RandomUserMeApi fakeUserDataApi = RandomUserMeApi();
  UserApi userApi = UserApi();
  int size = 20;
  Future<void> addNewUser() async {
    final RandomUserModel data = await fakeUserDataApi.getUser(size: size);
    var createAt = DateTime(2022, 1, 1);
    bool isMale = true;
    if (data.results != null && data.results!.isNotEmpty) {
      int fakeUserIndex = 0;
      int girlsPhotoIndex = 0;
      int boysPhotoIndex = 0;
      for (var e in data.results!) {
        var random = Random();
        String phone = '+84${random.nextIntOfDigits(9)}';
        var userModel = e.toUserModel();
        userModel = userModel.copyWith(
          id: 'zzfake_user_$fakeUserIndex',
          name: isMale
              ? MockBoyData.names[fakeUserIndex]
              : MockGirlData.names[fakeUserIndex],
          isFakeData: true,
          avatarUrl: isMale
              ? MockBoyData.images[0 + boysPhotoIndex]
              : MockGirlData.images[0 + girlsPhotoIndex],
          phoneNumber: phone,
          lastOnline: createAt,
          photoList: [
            PhotoModel(
                id: 0,
                url: isMale
                    ? MockBoyData.images[1 + boysPhotoIndex]
                    : MockGirlData.images[1 + girlsPhotoIndex],
                createAt: createAt),
            PhotoModel(
                id: 1,
                url: isMale
                    ? MockBoyData.images[2 + boysPhotoIndex]
                    : MockGirlData.images[2 + girlsPhotoIndex],
                createAt: createAt),
            PhotoModel(
                id: 2,
                url: isMale
                    ? MockBoyData.images[3 + boysPhotoIndex]
                    : MockGirlData.images[3 + girlsPhotoIndex],
                createAt: createAt),
            PhotoModel(
                id: 3,
                url: isMale
                    ? MockBoyData.images[4 + boysPhotoIndex]
                    : MockGirlData.images[4 + girlsPhotoIndex],
                createAt: createAt),
          ],
          hobbies: [
            InitData.hobbies[fakeUserIndex % 10 + 0],
            InitData.hobbies[fakeUserIndex % 10 + 1],
            InitData.hobbies[fakeUserIndex % 10 + 2],
            InitData.hobbies[fakeUserIndex % 10 + 3],
            InitData.hobbies[fakeUserIndex % 10 + 4],
          ],
          feedFilter: FeedFilterModel(
              distance: 50,
              interestedInGender:
                  isMale ? GenderType.male.id : GenderType.female.id,
              ageRange: AgeRangeModel()),
          premiumExpireAt: createAt,
        );
        print(userModel.toString());
        fakeUserIndex++;
        if (isMale) {
          boysPhotoIndex = boysPhotoIndex + 5;
        } else {
          girlsPhotoIndex = girlsPhotoIndex + 5;
        }
        isMale = !isMale;
        await userApi.profileSetup(userModel);
      }
    }
  }

  Future<void> removeNullUser() async {
    await userApi.deleteNullUser();
  }

  Future<void> removeMockUser() async {
    int i = 0;
    int max = size;
    for (; i < max; i++) {
      await userApi.deleteUser('zzfake_user_$i');
    }
  }
}
