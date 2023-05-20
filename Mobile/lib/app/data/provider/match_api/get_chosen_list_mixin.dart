part of 'match_api.dart';

mixin GetChosenListMixin on MatchApi {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<List<InteractedUserModel>> _chosenListController =
      StreamController<List<InteractedUserModel>>.broadcast();

  final List<List<InteractedUserModel>> _allChosenListPageResult =
      <List<InteractedUserModel>>[];
  DocumentSnapshot? _lastChosenDocument;
  bool _hasMoreChosenList = true;
  bool _isOnlyChosenList = false;

  @override
  Stream<List<InteractedUserModel>> listenToChosenListRealTime() {
    _requestChosenList();
    return _chosenListController.stream;
  }

  // #1: Move the request posts into it's own function
  Future _requestChosenList({bool loadMore = false}) async {
    final CollectionReference matchesCollectionRef =
        _firestore.collection(FirebaseStorageConstants.interactionCollection);
    // #2: split the query from the actual subscription
    var pageChosenListQuery = matchesCollectionRef
        .orderBy(FirebaseStorageConstants.updateAtField, descending: true)
        .where(FirebaseStorageConstants.interactedUserId,
            isEqualTo: _auth.currentUser?.uid)
        .where(FirebaseStorageConstants.interactedType,
            isEqualTo: InteractType.like.id)
        // #3: Limit the amount of results
        .limit(FirebaseStorageConstants.limitRequest);

    // #5: If we have a document start the query after it
    if (_lastChosenDocument != null) {
      pageChosenListQuery =
          pageChosenListQuery.startAfterDocument(_lastChosenDocument!);
    }

    // If hasMoreChosenList if false, push current chosenListList to stream
    if (!_hasMoreChosenList) {
      var allChosenList = _allChosenListPageResult
          .fold<List<InteractedUserModel>>(<InteractedUserModel>[],
              (initialValue, pageItems) => initialValue..addAll(pageItems));
      _chosenListController.add(allChosenList);
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allChosenListPageResult.length;

    pageChosenListQuery.snapshots().listen((chosenListsSnapshot) {
      // If ChosenList List has only one chosenList
      if (chosenListsSnapshot.docs.isEmpty && (_isOnlyChosenList)) {
        _isOnlyChosenList = false;
        _chosenListController.add([]);
      } else if (chosenListsSnapshot.docs.isNotEmpty) {
        var chosenLists = chosenListsSnapshot.docs
            .map((snapshot) => InteractedUserModel.fromSnapShot(
                snapshot as DocumentSnapshot<Map<String, dynamic>>))
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allChosenListPageResult.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allChosenListPageResult[currentRequestIndex] = chosenLists;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allChosenListPageResult.add(chosenLists);
        }

        // #11: Concatenate the full list to be shown
        var allChosenList = _allChosenListPageResult
            .fold<List<InteractedUserModel>>(<InteractedUserModel>[],
                (initialValue, pageItems) => initialValue..addAll(pageItems));
        // #12: Broadcase all posts
        _chosenListController.add(allChosenList);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allChosenListPageResult.length - 1) {
          _lastChosenDocument = chosenListsSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreChosenList =
            chosenLists.length == FirebaseStorageConstants.limitRequest;

        // Check is only ChosenList
        _isOnlyChosenList = allChosenList.length == 1;
      }
    });
  }

  @override
  void requestMoreChosenList() => _requestChosenList(loadMore: true);
}
