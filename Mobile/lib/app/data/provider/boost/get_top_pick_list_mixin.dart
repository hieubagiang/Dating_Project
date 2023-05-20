part of 'boost_api.dart';

mixin GetTopPickListMixin on BoostApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<List<BoostModel>> _topPickListController =
      StreamController<List<BoostModel>>.broadcast();

  final List<List<BoostModel>> _allPickListPageResult = <List<BoostModel>>[];
  DocumentSnapshot? _lastTopPickDocument;
  bool _hasMoreTopPickList = true;
  bool _isOnlyPickList = false;

  @override
  Stream<List<UserModel>> listenToTopPickListRealTime(String currentUserId) {
    _requestTopPickList(currentUserId);
    return _topPickListController.stream
        .transform(_transformBoostModelToUserModel());
  }

  // #1: Move the request posts into it's own function
  Future _requestTopPickList(String currentUserId,
      {bool loadMore = false}) async {
    final CollectionReference boostCollectionRef =
        _firestore.collection(FirebaseStorageConstants.boostCollection);
    // #2: split the query from the actual subscription

    var pageTopPickListQuery = boostCollectionRef
        .orderBy(FirebaseStorageConstants.expireAt, descending: true)
        .where(FirebaseStorageConstants.expireAt,
            isGreaterThan: DateTime.now().toIso8601String())
        // #3: Limit the amount of results
        .limit(FirebaseStorageConstants.limitRequest);

    // #5: If we have a document start the query after it
    if (_lastTopPickDocument != null) {
      pageTopPickListQuery =
          pageTopPickListQuery.startAfterDocument(_lastTopPickDocument!);
    }

    // If hasMoreTopPickList if false, push current topPickListList to stream
    if (!_hasMoreTopPickList) {
      var allTopPickList = _allPickListPageResult.fold<List<BoostModel>>(
          <BoostModel>[],
          (initialValue, pageItems) => initialValue..addAll(pageItems));
      _topPickListController.add(allTopPickList);
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allPickListPageResult.length;

    pageTopPickListQuery.snapshots().listen((topPickListsSnapshot) {
      // If PickList List has only one topPickList
      if (topPickListsSnapshot.docs.isEmpty && (_isOnlyPickList)) {
        _isOnlyPickList = false;
        _topPickListController.add([]);
      } else if (topPickListsSnapshot.docs.isNotEmpty) {
        var topPickLists = topPickListsSnapshot.docs
            .map((snapshot) => BoostModel.fromSnapShot(
                snapshot as DocumentSnapshot<Map<String, dynamic>>))
            .toList();
        // topPickLists.removeWhere((element) => element.userId ==currentUserId );
        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allPickListPageResult.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allPickListPageResult[currentRequestIndex] = topPickLists;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allPickListPageResult.add(topPickLists);
        }

        // #11: Concatenate the full list to be shownnn
        var allTopPickList = _allPickListPageResult.fold<List<BoostModel>>(
            <BoostModel>[],
            (initialValue, pageItems) => initialValue..addAll(pageItems));
        // #12: Broadcase all posts
        _topPickListController.add(allTopPickList);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allPickListPageResult.length - 1) {
          _lastTopPickDocument = topPickListsSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreTopPickList =
            topPickLists.length == FirebaseStorageConstants.limitRequest;

        // Check is only PickList
        _isOnlyPickList = allTopPickList.length == 1;
      }
    });
  }

  @override
  void requestMoreTopPickData(String currentUserId) =>
      _requestTopPickList(currentUserId, loadMore: true);

  StreamTransformer<List<BoostModel>, List<UserModel>>
      _transformBoostModelToUserModel() {
    return StreamTransformer<List<BoostModel>, List<UserModel>>.fromHandlers(
        handleData: (data, sink) async {
      if (data.isNotEmpty) {
        final CollectionReference userCollectionRef =
            _firestore.collection(FirebaseStorageConstants.usersCollection);
        var snapshot = await userCollectionRef
            .where(FieldPath.documentId,
                whereIn: data.map((e) => e.userId).toList())
            .get();

        List<UserModel> users = snapshot.docs
            .map((e) => UserModel.fromSnapShot(
                e as DocumentSnapshot<Map<String, dynamic>>))
            .toList();
        sink.add(users);
      } else {
        sink.add([]);
      }
    });
  }
}
