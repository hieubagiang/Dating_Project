import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model/filter_user_model/filter_user_model.dart';

abstract class _FeedApi {
  Future<List<UserModel>> getUserList(FeedFilterModel filter);

  Future<void> interactUser({required InteractedUserModel interactedUserModel});

  Future<void> isMatchUser(
      {required String userName1, required String userName2});
}

class FeedApi extends _FeedApi {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  DocumentSnapshot? _lastDocument;

  FeedApi({FirebaseAuth? auth, FirebaseFirestore? fireStore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = fireStore ?? FirebaseFirestore.instance;

  @override
  Future<List<UserModel>> getUserList(FeedFilterModel filter) async {
    var userCollection =
        _firestore.collection(FirebaseStorageConstants.usersCollection);
    var userQuery = userCollection
        .orderBy(FirebaseStorageConstants.idField)
        // .where(FirebaseStorageConstants.genderField,
        //     isEqualTo: filter.interestedInGender)
        // .where(FirebaseStorageConstants.ageField,
        //     isGreaterThanOrEqualTo: filter.ageRange!.start)
        // .where(FirebaseStorageConstants.ageField,
        //     isLessThanOrEqualTo: filter.ageRange!.end)
        .where(FirebaseStorageConstants.idField, isNull: false)
        .limit(FirebaseStorageConstants.limitRequest);

    if (_lastDocument != null) {
      userQuery = userQuery.startAfterDocument(_lastDocument!);
    }
    var snapshot = await userQuery.get();
    List<UserModel> response = snapshot.docs.map((e) {
      _lastDocument = e;
      return UserModel.fromSnapShot(e);
    }).toList();
    response.removeWhere((element) => (element.photoList == null ||
        element.photoList!.isEmpty ||
        element.id == (_auth.currentUser?.uid ?? '')));

    return response;
  }

  @override
  Future<void> interactUser(
      {required InteractedUserModel interactedUserModel}) async {
    CollectionReference itemsRef =
        _firestore.collection(FirebaseStorageConstants.interactionCollection);

    if (interactedUserModel.interactedType == InteractType.undo.id) {
      await itemsRef.doc(interactedUserModel.uniKey).delete();
      FunctionUtils.logWhenDebug(
          this, 'deleted "${interactedUserModel.uniKey}"');
    } else {
      await itemsRef
          .doc(interactedUserModel.uniKey)
          .set(interactedUserModel.toJson());
      FunctionUtils.logWhenDebug(this, 'interact success');
    }
  }

  @override
  Future<bool> isMatchUser(
      {required String userName1, required String userName2}) async {
    CollectionReference itemsRef =
        _firestore.collection(FirebaseStorageConstants.interactionCollection);
    var snapshot = await itemsRef
        .where(
          FirebaseStorageConstants.currentUserId,
          isEqualTo: userName1,
        )
        .where(
          FirebaseStorageConstants.interactedUserId,
          isEqualTo: userName2,
        )
        .where(FirebaseStorageConstants.interactedType,
            isEqualTo: InteractType.like.id)
        .get();
    return snapshot.size == 1;
  }

/*
  Future getUserhobbies(userId) async {
    User currentUser = User();

    await _firestore.collection('users').doc(userId).get().then((user) {
      currentUser.name = user['name'];
      currentUser.photo = user['photoUrl'];
      currentUser.gender = user['gender'];
      currentUser.interestedIn = user['interestedIn'];
    });
    return currentUser;
  }*/

  Future<List> getChosenList(userId) async {
    List<String> chosenList = [];
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('chosenList')
        .get()
        .then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        chosenList.add(doc.id);
      }
    });
    return chosenList;
  }

  //Getting userId.
  String? get userId => _auth.currentUser?.uid;
}
