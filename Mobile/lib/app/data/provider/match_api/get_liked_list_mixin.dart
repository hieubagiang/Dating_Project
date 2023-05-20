part of 'match_api.dart';

mixin GetLikedListMixin on MatchApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<List<InteractedUserModel>> _likeListController =
      StreamController<List<InteractedUserModel>>.broadcast();

  final List<List<InteractedUserModel>> _allLikeListPageResult =
      <List<InteractedUserModel>>[];
  DocumentSnapshot? _lastLikedDocument;
  bool _hasMoreLikedList = true;
  bool _isOnlyLikeList = false;

  @override
  Stream<List<InteractedUserModel>> listenToLikedListRealTime() {
    _requestLikedList();
    return _likeListController.stream;
  }

  // #1: Move the request posts into it's own function
  Future _requestLikedList({bool loadMore = false}) async {
    final CollectionReference matchesCollectionRef =
        _firestore.collection(FirebaseStorageConstants.interactionCollection);
    // #2: split the query from the actual subscription
    var pageLikedListQuery = matchesCollectionRef
        .orderBy(FirebaseStorageConstants.updateAtField, descending: true)
        .where(FirebaseStorageConstants.currentUserId,
            isEqualTo: _auth.currentUser?.uid)
        .where(FirebaseStorageConstants.interactedType,
            isEqualTo: InteractType.like.id)
        // #3: Limit the amount of results
        .limit(FirebaseStorageConstants.limitRequest);

    // #5: If we have a document start the query after it
    if (_lastLikedDocument != null) {
      pageLikedListQuery =
          pageLikedListQuery.startAfterDocument(_lastLikedDocument!);
    }

    // If hasMoreLikedList if false, push current likeListList to stream
    if (!_hasMoreLikedList) {
      var allLikedList = _allLikeListPageResult.fold<List<InteractedUserModel>>(
          <InteractedUserModel>[],
          (initialValue, pageItems) => initialValue..addAll(pageItems));
      _likeListController.add(allLikedList);
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allLikeListPageResult.length;

    pageLikedListQuery.snapshots().listen((likeListsSnapshot) {
      // If LikeList List has only one likeList
      if (likeListsSnapshot.docs.isEmpty && (_isOnlyLikeList)) {
        _isOnlyLikeList = false;
        _likeListController.add([]);
      } else if (likeListsSnapshot.docs.isNotEmpty) {
        var likeLists = likeListsSnapshot.docs
            .map((snapshot) => InteractedUserModel.fromSnapShot(
                snapshot as DocumentSnapshot<Map<String, dynamic>>))
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allLikeListPageResult.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allLikeListPageResult[currentRequestIndex] = likeLists;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allLikeListPageResult.add(likeLists);
        }

        // #11: Concatenate the full list to be shown
        var allLikedList = _allLikeListPageResult
            .fold<List<InteractedUserModel>>(<InteractedUserModel>[],
                (initialValue, pageItems) => initialValue..addAll(pageItems));
        // #12: Broadcase all posts
        _likeListController.add(allLikedList);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allLikeListPageResult.length - 1) {
          _lastLikedDocument = likeListsSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreLikedList =
            likeLists.length == FirebaseStorageConstants.limitRequest;

        // Check is only LikeList
        _isOnlyLikeList = allLikedList.length == 1;
      }
    });
  }

  @override
  void requestMoreLikedData() => _requestLikedList(loadMore: true);
}
