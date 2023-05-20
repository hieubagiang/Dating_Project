import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/models/interaction/matched_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'get_chosen_list_mixin.dart';

part 'get_liked_list_mixin.dart';

part 'get_matched_list_mixin.dart';

abstract class MatchApi {
  Stream<List<InteractedUserModel>> listenToLikedListRealTime();

  void requestMoreLikedData();

  Stream<List<InteractedUserModel>> listenToChosenListRealTime();

  Stream<List<MatchedUserModel>> listenToMatchedListRealTime();

  void requestMoreChosenList();

  Future<List<ChannelModel>> queryMatchedList({required String name});
}

class MatchApiImplement extends MatchApi
    with GetLikedListMixin, GetChosenListMixin, GetMatchedListMixin {
  //Getting userId.
  String? get userId => _auth.currentUser?.uid;

  @override
  Future<List<ChannelModel>> queryMatchedList({required String name}) async {
    final CollectionReference channelsCollectionRef =
        _firestore.collection(FirebaseStorageConstants.channelsCollection);
    // #2: split the query from the actual subscription

    var querySnapshots = await channelsCollectionRef
        .where(FirebaseStorageConstants.memberIdsField,
            arrayContains: _auth.currentUser!.uid)
        .orderBy(FirebaseStorageConstants.updateAtField, descending: true)
        .get();
    // #3: Limit the amount of results
    List<ChannelModel> list = [];
    if (name.isEmpty) {
      return [];
    }
    list.addAll(querySnapshots.docs
        .map((e) => ChannelModel.fromSnapShot(
            e as DocumentSnapshot<Map<String, dynamic>>))
        .toList());

    return list
        .where((element) => element.members!
            .where((element) => element.name!.contains(name))
            .isNotEmpty)
        .toList();
  }
}
