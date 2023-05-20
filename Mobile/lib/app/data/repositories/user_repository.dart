import 'package:dating_app/app/common/utils/functions.dart';
import 'package:dating_app/app/data/models/subscription_package_model/subscription_package_model.dart';
import 'package:dating_app/app/data/models/user_model/filter_user_model/filter_user_model.dart';
import 'package:dating_app/app/data/models/user_model/hobby_model/hobby_model.dart';
import 'package:dating_app/app/data/models/user_model/position_model/position_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/provider/hobby_api.dart';
import 'package:dating_app/app/data/provider/user_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserRepository {
  final api = Get.find<UserApi>();
  final interestApi = Get.find<HobbyApi>();

  //Profile Setup
  Future<void> profileSetup(UserModel user) async {
    await api.profileSetup(user);
  } //Profile Setup

  User? getFireBaseUser() {
    return api.getFireBaseUser();
  }

  Future<UserModel?> getUser({String? userId}) async {
    return await api.getUser(userId: userId);
  }

  Stream<UserModel?> listenUser({String? userId}) async* {
    yield* api.listenUser(userId: userId);
  }

  Future<void> updateUserPictures(String imageName) async {
    return api.updateUserPictures(imageName);
  }

  Future<void> updateFCMToken(String fcmToken) async {
    return api.updateFCMToken(fcmToken);
  }

  Future<void> updateUser(UserModel user) async {
    return api.updateUser(user);
  }

  Future<void> updateUserLocation(PositionModel position) async {
    return api.updateUserLocation(position);
  }

  Future<void> updateInteractedFilter(FeedFilterModel model) async {
    return api.updateInteractedFilter(model);
  }

  Future<void> createInterestCollection(List<HobbyModel> list) async {
    return interestApi.createInterestCollection(list);
  }

  Future<List<HobbyModel>> getHobbyList() async {
    return await interestApi.getHobbyList();
  }

  Future<bool> checkServerInitData() async {
    interestApi.checkServerInitData();
    return Future.value(true);
  }

  Future<List<SubscriptionPackageModel>> getSubscriptionPackages() async {
    return await api.getSubscriptionPackages();
  }

  Future<void> createGuestUser() async {
    if (FirebaseAuth.instance.currentUser?.uid == null) return;
    FunctionUtils.logWhenDebug(
        this, 'createGuestUser - ${FirebaseAuth.instance.currentUser?.uid}');
    await api.profileSetup(
      UserModel.createGuestUser(
        FirebaseAuth.instance.currentUser?.uid ?? '',
      ),
    );
  }

  //Getting userId.
  String? get currentUserId => api.userId;
}
