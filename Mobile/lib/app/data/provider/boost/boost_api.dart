import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';
import 'package:dating_app/app/data/models/boost/boost_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_top_pick_list_mixin.dart';

part 'listen_user_boost_status_mixin.dart';

abstract class BoostApi {
  Future<void> boostProfile();

  Stream<BoostModel?> listenToUserBoostStatusRealTime({required String userId});

  Stream<List<UserModel>> listenToTopPickListRealTime(String currentUserId);

  void requestMoreTopPickData(String currentUserId);
}

class BoostApiImplement extends BoostApi
    with GetTopPickListMixin, ListenUserBoostStatusMixin {
  final ref = 'matches';

  // DocumentSnapshot? _lastTopPicks;

  //Getting userId.
  String? get userId => _auth.currentUser?.uid;

  @override
  Future<void> boostProfile() {
    ///  todo check permission before boost
    var now = DateTime.now();
    return _firestore
        .collection(FirebaseStorageConstants.boostCollection)
        .doc()
        .set(BoostModel(
                userId: userId!,
                expireAt: now.add(Duration(
                    minutes:
                        FirebaseStorageConstants.limitBoostProfileInMinute)),
                createAt: now)
            .toJson());
  }
}
