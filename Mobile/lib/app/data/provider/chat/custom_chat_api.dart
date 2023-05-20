import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';

class CustomChatApi {
  final int messagesPerPage = 10;
  final channelsRef = FirebaseFirestore.instance.collection('channels');

  Stream<QuerySnapshot> listenToMessages(
      {required String channelId, DocumentSnapshot? lastMessage}) {
    Query query = channelsRef
        .doc(channelId)
        .collection('messages')
        .orderBy(FirebaseStorageConstants.createAtField, descending: true)
        .limit(messagesPerPage);

    if (lastMessage != null) {
      query = query.startAfterDocument(lastMessage);
    }

    return query.snapshots();
  }
}
