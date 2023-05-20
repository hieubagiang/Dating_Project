import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/strings.dart';
import 'package:dating_app/app/data/mock_data/mock_data.dart';
import 'package:dating_app/app/data/models/user_model/hobby_model/hobby_model.dart';

class HobbyApi {
  final FirebaseFirestore _firestore;

  HobbyApi({FirebaseFirestore? fireStore})
      : _firestore = fireStore ?? FirebaseFirestore.instance;

  Future<void> createInterestCollection(List<HobbyModel> list) async {
    for (var model in list) {
      await _firestore
          .collection(InitData.hobbiesFieldName)
          .doc(model.id.toString())
          .set(model.toJson());
    }
  }

  Future<void> checkServerInitData() async {
    _firestore
        .collection(InitData.hobbiesFieldName)
        .snapshots()
        .first
        .then((snapshot) {
      if (snapshot.size == 0) {
        createInterestCollection(InitData.hobbies);
      }
      print('${snapshot.size}');
    });
  }

  Future<List<HobbyModel>> getHobbyList() async {
    List<HobbyModel> hobbies = [];
    try {
      final hobbiesQuery = await _firestore
          .collection(InitData.hobbiesFieldName)
          .orderBy('id')
          .get();
      for (final doc in hobbiesQuery.docs) {
        HobbyModel categoryModel = HobbyModel.fromJson(doc.data());
        hobbies.add(categoryModel);
      }
    } on Exception catch (e) {
      throw FirebaseException(
          plugin: StringUtils.appName,
          message: 'InterestApi - getInterestList - error: ${e.toString()}');
    }
    return hobbies;
  }
}
