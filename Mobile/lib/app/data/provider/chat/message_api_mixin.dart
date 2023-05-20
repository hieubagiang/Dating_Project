part of 'chat_api.dart';

mixin MessageApiMixin on ChatApi {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Transaction List
  final StreamController<List<MessageModel>> _messageListController =
      StreamController<List<MessageModel>>.broadcast();

  final List<List<MessageModel>> _allMessagePageResult = <List<MessageModel>>[];
  DocumentSnapshot? _lastChosenDocument;
  bool _hasMoreMessageList = true;

  @override
  Stream<List<MessageModel>> listenToChannel(String channelId) {
    _requestMessageList(channelId: channelId);
    return _messageListController.stream;
  }

  // #1: Move the request posts into it's own function
  Future _requestMessageList(
      {required String channelId, bool loadMore = false}) async {
    final CollectionReference messagesCollectionRef = _firestore
        .collection(FirebaseStorageConstants.channelsCollection)
        .doc(channelId)
        .collection(FirebaseStorageConstants.messagesCollection);
    // #2: split the query from the actual subscription

    var pageMessageListQuery = messagesCollectionRef
        .orderBy(FirebaseStorageConstants.createAtField, descending: true)
        .limit(FirebaseStorageConstants.limitRequest);

    // #5: If we have a document start the query after it
    if (_lastChosenDocument != null) {
      pageMessageListQuery =
          pageMessageListQuery.startAfterDocument(_lastChosenDocument!);
    }

    // If hasMoreMessageList if false, push current chosenListList to stream
    if (!_hasMoreMessageList) {
      var allMessageList = _allMessagePageResult.fold<List<MessageModel>>(
          <MessageModel>[],
          (initialValue, pageItems) => initialValue..addAll(pageItems));
      _messageListController.add(allMessageList);
      return;
    }

    // #7: Get and store the page index that the results belong to
    var currentRequestIndex = _allMessagePageResult.length;

    pageMessageListQuery.snapshots().listen((messageListSnapshot) {
      // If LikeList List has only one chosenList
      if (messageListSnapshot.docs.isNotEmpty) {
        var messageList = messageListSnapshot.docs
            .map(
              (snapshot) => MessageModel.fromSnapShot(
                snapshot as DocumentSnapshot<Map<String, dynamic>>,
              ),
            )
            .toList();

        // #8: Check if the page exists or not
        var pageExists = currentRequestIndex < _allMessagePageResult.length;

        // #9: If the page exists update the posts for that page
        if (pageExists) {
          _allMessagePageResult[currentRequestIndex] = messageList;
        }
        // #10: If the page doesn't exist add the page data
        else {
          _allMessagePageResult.add(messageList);
        }

        // #11: Concatenate the full list to be shown
        var allMessageList = _allMessagePageResult.fold<List<MessageModel>>(
            <MessageModel>[],
            (initialValue, pageItems) => initialValue..addAll(pageItems));
        // #12: Broadcase all posts
        _messageListController.add(allMessageList);

        // #13: Save the last document from the results only if it's the current last page
        if (currentRequestIndex == _allMessagePageResult.length - 1) {
          _lastChosenDocument = messageListSnapshot.docs.last;
        }

        // #14: Determine if there's more posts to request
        _hasMoreMessageList =
            messageList.length == FirebaseStorageConstants.limitRequest;
      }
    });
  }

  @override
  void requestMoreMessage(String channelId) =>
      _requestMessageList(loadMore: true, channelId: channelId);
}
