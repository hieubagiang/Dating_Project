import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';
import 'package:dating_app/app/common/utils/functions.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/chat/member_model.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';

import '../../../common/utils/strings.dart';

part 'channel_api_mixin.dart';
part 'message_api_mixin.dart';

abstract class ChatApi {
  Stream<List<MessageModel>> listenToChannel(String channelId);

  Future<ChannelModel> createChannel(
      {required MemberModel currentUser, required MemberModel selectedUser});

  Future<void> updateChannel(
      {required String channelId, required ChannelModel channelModel});

  Stream<ChannelModel> getChannel({required String channelId});

  Stream<List<ChannelModel>> queryAllChannel({required String currentID});

  Future<void> deleteChat(
      {required String currentUserId, required String selectedUserId});

  Future<void> sendMessage(
      {required String channelId, required MessageModel message});

  void requestMoreMessage(String channelId);

  void requestMoreChannelList(String currentID);
}

class ChatApiImpl extends ChatApi with MessageApiMixin, ChannelApiMixin {
  @override
  Future<ChannelModel> createChannel(
      {required MemberModel currentUser,
      required MemberModel selectedUser}) async {
    String channelId =
        FunctionUtils.getGroupChatId(currentUser.id, selectedUser.id);
    var now = DateTime.now();
    var channelModel = ChannelModel(
        channelId: channelId,
        memberIds: [currentUser.id!, selectedUser.id!],
        members: [currentUser, selectedUser],
        createAt: now,
        updateAt: now);
    await _firestore
        .collection(FirebaseStorageConstants.channelsCollection)
        .doc(channelId)
        .set(channelModel.toJson());
    //add channel fields to usersCollection
    await sendMessage(
        channelId: channelId,
        message: MessageModel.firstMessage(),
        isOnlyDataMessage: false);
    //Send notification

    return channelModel;
  }

  @override
  Future<void> deleteChat(
      {required String currentUserId, required String selectedUserId}) async {
    await _firestore
        .collection(FirebaseStorageConstants.channelsCollection)
        .doc(FunctionUtils.getGroupChatId(currentUserId, selectedUserId))
        .delete();
  }

  /// isOnlyDataMessage đánh dấu tín nhắn đc gửi bởi system
  @override
  Future<void> sendMessage({
    required String channelId,
    required MessageModel message,
    List<String>? members,
    bool isOnlyDataMessage = false,
    bool isUpdateMessage = false,
  }) async {
    DocumentReference channel = _firestore
        .collection(FirebaseStorageConstants.channelsCollection)
        .doc(channelId);
    await channel
        .collection(FirebaseStorageConstants.messagesCollection)
        .doc('${message.messageId}')
        .set(message.toJson(), SetOptions(merge: true));
    if (isUpdateMessage) {
      // get last message id from field last_message
      final lastMessageId =
          (await channel.get()).get('last_message')['message_id'];
      if (lastMessageId != null && lastMessageId != message.messageId) {
        await channel
            .collection(FirebaseStorageConstants.messagesCollection)
            .doc(lastMessageId)
            .update({'last_message': message.toJson()});
      }
    } else {
      await channel
          .set({'last_message': message.toJson()}, SetOptions(merge: true));
    }
    final channelModel = ChannelModel.fromSnapShot(
        await channel.get() as DocumentSnapshot<Map<String, dynamic>>);
    //GET TOKEN to send message
    var receiverToken = (await _firestore
            .collection(FirebaseStorageConstants.usersCollection)
            .doc(channelModel.memberIds
                ?.where((element) => element != message.senderId)
                .first)
            .get())
        .get(FirebaseStorageConstants.tokenField);
    if (message.text != StringUtils.firstChatMessage) {
      // TODO
      // await _pushNotificationApi
      //     .sendNotificationByFCMToken(
      //         PushNotificationRequest(
      //             data: PushNotificationDataRequest(
      //                 title: message.senderName,
      //                 body: message.text?.isNotEmpty ?? false
      //                     ? message.text
      //                     : 'Đã gửi 1 tệp đính kèm',
      //                 clickAction: 'FLUTTER_NOTIFICATION_CLICK',
      //                 channel: channelModel,
      //                 messageType: message.messageType,
      //                 messageModel: message),
      //             notification:
      //                 isOnlyDataMessage
      //                     ? null
      //                     : NotificationRequest(
      //                         title: message.senderName,
      //                         body: message.text,
      //                         sound: 'new_message'),
      //             to: receiverToken));
    }
  }

  @override
  Stream<ChannelModel> getChannel({required String channelId}) async* {
    DocumentReference channel = _firestore
        .collection(FirebaseStorageConstants.channelsCollection)
        .doc(channelId);
    yield* channel.snapshots().map((snapshot) {
      return ChannelModel.fromSnapShot(
          snapshot as DocumentSnapshot<Map<String, dynamic>>);
    });
  }

  @override
  Future<void> updateChannel(
      {required String channelId, required ChannelModel channelModel}) async {
    await _firestore
        .collection(FirebaseStorageConstants.channelsCollection)
        .doc(channelId)
        .update(channelModel.copyWith(updateAt: DateTime.now()).toJson());
  }
}
