part of 'match_api.dart';

mixin GetMatchedListMixin on MatchApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<List<MatchedUserModel>> _matchedListController =
      StreamController<List<MatchedUserModel>>.broadcast();

  final List<List<MatchedUserModel>> _allMatchedListPageResult =
      <List<MatchedUserModel>>[];
  DocumentSnapshot? _lastMatchedDocument;
  bool _hasMoreMatchedList = true;
  // bool _isOnlyMatchedList = false;

  @override
  Stream<List<MatchedUserModel>> listenToMatchedListRealTime() {
    _requestMatchedList();
    return _matchedListController.stream;
  }

  // #1: Move the request posts into it's own function
  Future _requestMatchedList({bool loadMore = false}) async {
    final CollectionReference matchesCollectionRef =
        _firestore.collection(FirebaseStorageConstants.interactionCollection);
    // #2: split the query from the actual subscription
    var pageMatchedListQuery = matchesCollectionRef
        .orderBy(FirebaseStorageConstants.updateAtField, descending: true)
        .where(FirebaseStorageConstants.currentUserId,
            isEqualTo: _auth.currentUser?.uid)
        .where(FirebaseStorageConstants.interactedType,
            isEqualTo: InteractType.matched.id)
        // #3: Limit the amount of results
        .limit(10);

    // #5: If we have a document start the query after it
    if (_lastMatchedDocument != null) {
      pageMatchedListQuery =
          pageMatchedListQuery.startAfterDocument(_lastMatchedDocument!);
    }

    // If hasMoreMatchedList if false, push current matchedListList to stream
    if (!_hasMoreMatchedList) {
      var allMatchedList = _allMatchedListPageResult
          .fold<List<MatchedUserModel>>(<MatchedUserModel>[],
              (initialValue, pageItems) => initialValue..addAll(pageItems));
      _matchedListController.add(allMatchedList);
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allMatchedListPageResult.length;

    pageMatchedListQuery.snapshots().listen((matchedListsSnapshot) {
      // If MatchedList List has only one matchedList
      if (matchedListsSnapshot.docs.isEmpty) {
        _matchedListController.add([]);
      } else if (matchedListsSnapshot.docs.isNotEmpty) {
        var matchedLists = matchedListsSnapshot.docs
            .map((snapshot) => InteractedUserModel.fromSnapShot(
                    snapshot as DocumentSnapshot<Map<String, dynamic>>)
                .interactedUser)
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allMatchedListPageResult.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allMatchedListPageResult[currentRequestIndex] = matchedLists;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allMatchedListPageResult.add(matchedLists);
        }

        // #11: Concatenate the full list to be shown
        var allMatchedList = _allMatchedListPageResult
            .fold<List<MatchedUserModel>>(<MatchedUserModel>[],
                (initialValue, pageItems) => initialValue..addAll(pageItems));
        // #12: Broadcase all posts
        _matchedListController.add(allMatchedList);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allMatchedListPageResult.length - 1) {
          _lastMatchedDocument = matchedListsSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreMatchedList =
            matchedLists.length == FirebaseStorageConstants.limitRequest;

        // Check is only MatchedList
        // _isOnlyMatchedList = allMatchedList.length == 1;
      }
    });
  }

  void requestMoreMatchedList() => _requestMatchedList(loadMore: true);
}
