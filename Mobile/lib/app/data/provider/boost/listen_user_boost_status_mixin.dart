part of 'boost_api.dart';

mixin ListenUserBoostStatusMixin on BoostApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<BoostModel> _listenUserBoostStatusController =
      StreamController<BoostModel>.broadcast();

  @override
  Stream<BoostModel?> listenToUserBoostStatusRealTime(
      {required String userId}) {
    _requestUserBoostStatus(userId: userId);
    return _listenUserBoostStatusController.stream;
  }

  Future _requestUserBoostStatus({required String userId}) async {
    final CollectionReference boostCollectionRef =
        _firestore.collection(FirebaseStorageConstants.boostCollection);
    var query = boostCollectionRef
        .where(FirebaseStorageConstants.userId, isEqualTo: userId)
        .orderBy(FirebaseStorageConstants.createAtField, descending: true)
        .limit(1);

    query.snapshots().listen((querySnapshots) {
      if (querySnapshots.docs.isEmpty) {
      } else if (querySnapshots.docs.isNotEmpty) {
        var model = BoostModel.fromSnapShot(querySnapshots.docs.first
            as DocumentSnapshot<Map<String, dynamic>>);
        _listenUserBoostStatusController.add(model);
      }
    });
  }
}
