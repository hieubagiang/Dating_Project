import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:dating_app/app/data/provider/chat/chat_api.dart';
import 'package:dating_app/app/data/provider/user_api.dart';
import 'package:get/get.dart';

abstract class ChatRepository {
  Stream<List<MessageModel>> listenToChannel(String channelId);

  void requestMoreMessage(String channelId);

  Future<ChannelModel> createChannel(
      {String? currentUserId, required String selectedUserId});

  Future<void> updateChannel(
      {required String channelId, required ChannelModel channelModel});

  Stream<ChannelModel> getChannel({required String channelId});

  Stream<List<ChannelModel>> queryAllChannel({required String currentID});

  void requestMoreChannelList(String currentID);

  Future<void> sendMessage(
      {required String channelId,
      required MessageModel message,
      bool isUpdate = false});

  Future<void> deleteChat(
      {required String currentUserId, required String selectedUserId});
}

class ChatRepositoryImpl extends ChatRepository {
  final _api = ChatApiImpl();
  final _userApi = Get.find<UserApi>();

  @override
  Future<ChannelModel> createChannel(
      {String? currentUserId, required String selectedUserId}) async {
    final currentUser =
        (await _userApi.getUser(userId: currentUserId))?.toMember();
    final selectedUser =
        (await _userApi.getUser(userId: selectedUserId))?.toMember();
    return await _api.createChannel(
        currentUser: currentUser!, selectedUser: selectedUser!);
  }

  @override
  Stream<List<MessageModel>> listenToChannel(String channelId) async* {
    yield* _api.listenToChannel(channelId);
  }

  @override
  void requestMoreMessage(String channelId) {
    _api.requestMoreMessage(channelId);
  }

  @override
  Future<void> deleteChat(
      {required String currentUserId, required String selectedUserId}) async {
    await _api.deleteChat(
        currentUserId: currentUserId, selectedUserId: selectedUserId);
  }

  @override
  Future<void> sendMessage({
    required String channelId,
    required MessageModel message,
    bool isUpdate = false,
  }) async {
    await _api.sendMessage(
        channelId: channelId, message: message, isUpdateMessage: isUpdate);
  }

  @override
  Stream<ChannelModel> getChannel({required String channelId}) async* {
    yield* _api.getChannel(channelId: channelId);
  }

  @override
  Future<void> updateChannel(
      {required String channelId, required ChannelModel channelModel}) async {
    await _api.updateChannel(channelId: channelId, channelModel: channelModel);
  }

  @override
  Stream<List<ChannelModel>> queryAllChannel(
      {required String currentID}) async* {
    yield* _api.queryAllChannel(currentID: currentID);
  }

  @override
  void requestMoreChannelList(String currentID) {
    _api.requestMoreChannelList(currentID);
  }
}
