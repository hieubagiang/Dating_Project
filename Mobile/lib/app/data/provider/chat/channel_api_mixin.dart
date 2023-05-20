part of 'chat_api.dart';

mixin ChannelApiMixin on ChatApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<List<ChannelModel>> _channelListController =
      StreamController<List<ChannelModel>>.broadcast();

  final List<List<ChannelModel>> _allChannelPageResult = <List<ChannelModel>>[];
  DocumentSnapshot? _lastChannelsDocument;
  bool _hasMoreChannelList = true;

  @override
  Stream<List<ChannelModel>> queryAllChannel({required String currentID}) {
    _requestChannelList(currentID: currentID);
    return _channelListController.stream;
  }

  // #1: Move the request posts into it's own function
  Future _requestChannelList(
      {required String currentID, bool loadMore = false}) async {
    final CollectionReference channelsCollectionRef =
        _firestore.collection(FirebaseStorageConstants.channelsCollection);
    // #2: split the query from the actual subscription

    var pageChannelListQuery = channelsCollectionRef
        .orderBy(FirebaseStorageConstants.updateAtField, descending: true)
        .where(FirebaseStorageConstants.memberIdsField,
            arrayContains: currentID)
        .limit(FirebaseStorageConstants.limitRequest);

    // #5: If we have a document start the query after it
    if (_lastChannelsDocument != null) {
      pageChannelListQuery =
          pageChannelListQuery.startAfterDocument(_lastChannelsDocument!);
    }

    // If hasMoreChannelList if false, push current chosenListList to stream
    if (!_hasMoreChannelList) {
      var allChannelList = _allChannelPageResult.fold<List<ChannelModel>>(
          <ChannelModel>[],
          (initialValue, pageItems) => initialValue..addAll(pageItems));
      _channelListController.add(allChannelList);
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allChannelPageResult.length;

    pageChannelListQuery.snapshots().listen((channelListSnapshot) {
      // If LikeList List has only one chosenList
      if (channelListSnapshot.docs.isNotEmpty) {
        var channelList = channelListSnapshot.docs
            .map((snapshot) => ChannelModel.fromSnapShot(
                snapshot as DocumentSnapshot<Map<String, dynamic>>))
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allChannelPageResult.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allChannelPageResult[currentRequestIndex] = channelList;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allChannelPageResult.add(channelList);
        }

        // #11: Concatenate the full list to be shown
        var allChannelList = _allChannelPageResult.fold<List<ChannelModel>>(
            <ChannelModel>[],
            (initialValue, pageItems) => initialValue..addAll(pageItems));
        // #12: Broadcase all posts
        _channelListController.add(allChannelList);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allChannelPageResult.length - 1) {
          _lastChannelsDocument = channelListSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreChannelList =
            channelList.length == FirebaseStorageConstants.limitRequest;
      } else {
        _channelListController.add([]);
        _hasMoreChannelList = false;
      }
    });
  }

  @override
  void requestMoreChannelList(String currentID) =>
      _requestChannelList(loadMore: true, currentID: currentID);
}
