import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/data/models/subscription_package_model/subscription_package_model.dart';
import 'package:dating_app/app/data/models/user_model/filter_user_model/filter_user_model.dart';
import 'package:dating_app/app/data/models/user_model/position_model/position_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/provider/auth_api.dart';
import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/utils/index.dart';

class UserApi {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final AuthApi _authApi = AuthApi();

  UserApi({FirebaseAuth? auth, FirebaseFirestore? fireStore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = fireStore ?? FirebaseFirestore.instance;

  //Profile Setup
  Future<void> profileSetup(UserModel user) async {
    await _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(user.id)
        .set(user.toJson());
  } //Profile Setup

  Future<void> deleteUser(String userId) async {
    await _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .delete();
  } //Profile Setup

  Future<void> deleteNullUser() async {
    final snapshot = await _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .get();
    for (var e in snapshot.docs) {
      if (e.data().containsKey('id') == false) {
        await deleteUser(e.id);
        print(e.data().toString());
      }
    }
  } //Pr

  User? getFireBaseUser() {
    return _auth.currentUser;
  }

  Future<UserModel?> getUser({String? userId}) async {
    userId ??= this.userId;
    if (userId == null) {
      return null;
    }

    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection(FirebaseStorageConstants.usersCollection)
          .doc(userId)
          .get();
      UserModel model = UserModel.fromSnapShot(snapshot);
      return model;
    } catch (e) {
      FunctionUtils.logWhenDebug(this, e.toString());
    }
    return null;
  }

  Stream<UserModel?> listenUser({String? userId}) async* {
    userId ??= this.userId;

    // final isExist = await _authApi.isExistUserData(userId!);
    // if (!isExist) {
    //   yield null;
    // }
    try {
      yield* _firestore
          .collection(FirebaseStorageConstants.usersCollection)
          .doc(userId)
          .snapshots()
          .map((snapshot) {
        return UserModel.fromSnapShot(snapshot);
      });
    } catch (e) {
      FunctionUtils.logWhenDebug(this, e.toString());
    }
    // yield null;
  }

  Future<String> getFCMToken({String? userId}) async {
    userId ??= this.userId;
    return (await _firestore
            .collection(FirebaseStorageConstants.usersCollection)
            .doc(userId)
            .get())
        .get(FirebaseStorageConstants.tokenField);
  }

  Future<void> updateUserPictures(String imageName) async {
    String downloadUrl = await StorageRepository().getDownloadURL(imageName);

    return _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .update({
      'avatarUrl': FieldValue.arrayUnion([downloadUrl])
    });
  }

  Future<void> updateFCMToken(String fcmToken) async {
    return _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .set(
      {
        FirebaseStorageConstants.tokenField: fcmToken,
      },
      SetOptions(merge: true),
    );
  }

  Future<void> updateUser(UserModel user) async {
    return _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .update(user.toJson());
  }

  Future<void> updateUserLocation(PositionModel position) async {
    return _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .set({FirebaseStorageConstants.locationField: position.toJson()},
            SetOptions(merge: true));
  }

  Future<void> updateInteractedFilter(FeedFilterModel model) async {
    return _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .set(
      {FirebaseStorageConstants.feedFilterField: model.toJson()},
      SetOptions(merge: true),
    );
  }

  Future<List<SubscriptionPackageModel>> getSubscriptionPackages() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('subscription_packages')
        .get();

    return SubscriptionPackageModel.fromQuerySnapshot(snapshot);
  }

  //Getting userId.
  String? get userId => _auth.currentUser?.uid;
}
