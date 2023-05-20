import 'dart:async';
import 'dart:io';

import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:dating_app/app/common/extension/extensions.dart';
import 'package:dating_app/app/data/models/basic_user/basic_user.dart';
import 'package:dating_app/app/data/models/chat/attachment_model.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/chat/member_model.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/message_repository.dart';
import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:file_picker/src/platform_file.dart';
import 'package:flutter/cupertino.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:uuid/uuid.dart';

import '../../../../data/enums/call_status_enum.dart';
import '../../../../data/enums/call_type.dart';
import '../../../../data/enums/message_type_enum.dart';
import '../../../../data/models/call/call_model.dart';
import '../../../../data/provider/chat/custom_chat_api.dart';
import '../../call_module/call_controller.dart';

class DetailMessageListController extends BaseController {
  final ChatRepository chatRepository = ChatRepositoryImpl();
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  String channelId = Get.parameters['id'] ?? '';
  Rx<ChannelModel> channel = Rx(ChannelModel());
  Rx<MemberModel> selectedUser = Rx(MemberModel());
  final messageTextController = TextEditingController();
  RxList<MessageModel> messageList = RxList<MessageModel>([]);
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final commonController = Get.find<CommonController>();
  final storageRepository = Get.find<StorageRepository>();
  final CustomChatApi chatApi = CustomChatApi();
  RxBool isOpenGallery = false.obs;
  RxBool isTyping = false.obs;
  List<StreamSubscription> subscriptions = [];
  Rx<BaseStateStatus> dataState = BaseStateStatus.init.obs;
  RxBool isShowEmoji = false.obs;
  RxBool isShowMedia = false.obs;

  FocusNode focusNode = FocusNode();

  RxList<Media> mediaList = RxList<Media>([]);

  @override
  Future<void> onInit() async {
    super.onInit();
    // messageList = chatRepository.listenToChannel(channelId);
    chatRepository.listenToChannel(channelId).listen((messageListEvent) async {
      // messageList.clear();
      messageList.value = messageListEvent;
      dataState.value = BaseStateStatus.success;
    }).addToList(subscriptions);

    logWhenDebug(this, 'channelId = $channelId');
    chatRepository.getChannel(channelId: channelId).first.then((channelModel) {
      channel.value = channelModel;

      if ((channelModel.members?.length ?? 0) >= 2) {
        for (var tmp in channelModel.members!) {
          if (tmp.id != currentUser.value?.id) {
            selectedUser.value = tmp;
          }
        }
      }
    });
    messageTextController.addListener(() {
      isTyping.value = messageTextController.text.isNotEmpty;
    });
    isShowMedia.stream.listen((isShowMedia) {
      if (!isShowMedia) {
        mediaList.clear();
      }
    }).addToList(subscriptions);
  }

  @override
  void onReady() {
    super.onReady();

    messageList.refresh();
  }

  Future<void> sendMessage(
      {List<Media>? listMedia, List<PlatformFile>? files}) async {
    List<Attachment> attachments = [];

    if (listMedia?.isNotEmpty ?? false) {
      List<Future<Attachment>> futures = [];
      for (final media in listMedia ?? []) {
        futures.add(uploadAttachment(media.file!));
      }
      attachments = await Future.wait(futures);
    } else if (files?.isNotEmpty ?? false) {
      List<Future<Attachment>> futures = [];
      for (final PlatformFile file in files ?? []) {
        futures.add(uploadAttachment(File(file.path!)));
      }
      attachments = await Future.wait(futures);
    }
    var now = DateTime.now();

    var message = MessageModel(
      messageId: now.millisecondsSinceEpoch.toString(),
      messageType: MessageType.normal,
      senderId: currentUser.value?.id,
      senderName: currentUser.value?.name,
      avatarUrl: currentUser.value?.avatarUrl,
      text: messageTextController.text,
      createAt: now,
      attachments: attachments,
    );
    messageTextController.clear();

    await chatRepository.sendMessage(channelId: channelId, message: message);

    //update unreadCount
    var updatedMemberModel = channel.value.members
        ?.map(
          (e) => e.id == currentUser.value?.id
              ? e
              : e.copyWith(unreadCount: e.unreadCount + 1),
        )
        .toList();
    await chatRepository.updateChannel(
      channelId: channelId,
      channelModel: channel.value.copyWith(members: updatedMemberModel),
    );
  }

  @override
  void onClose() {
    for (final subscription in subscriptions) {
      subscription.cancel();
    }
    messageTextController.dispose();
    super.onClose();
  }

  Future<void> onSendMedia(List<Media> listMedia) async {
    commonController.startLoading();
    if (listMedia.isEmpty) {
      commonController.stopLoading();
      return;
    }
    List<Attachment> attachments = [];
    List<Future<Attachment>> futures = [];
    for (final media in listMedia) {
      futures.add(uploadAttachment(media.file!));
    }
    attachments = await Future.wait(futures);

    var now = DateTime.now();

    var message = MessageModel(
      messageId: now.millisecondsSinceEpoch.toString(),
      senderId: currentUser.value?.id,
      senderName: currentUser.value?.name,
      avatarUrl: currentUser.value?.avatarUrl,
      attachments: attachments,
      createAt: now,
    );

    await chatRepository.sendMessage(channelId: channelId, message: message);
    isShowMedia.value = false;

    commonController.stopLoading();
  }

  Future<Attachment> uploadAttachment(File image) async {
    final imageUrl = await storageRepository.uploadFile(image);
    return imageUrl;
  }

  void ringCallee(CallType callType) {
    // Get.find<CallController>().startCall(
    //     controller.channelId,
    //     controller.currentUser.value?.name ?? '',
    //     controller.currentUser.value?.avatarUrl ?? '');
    final uuid = Uuid().v4();
    var now = DateTime.now();
    final callModel = CallModel(
      callId: uuid,
      channelId: channelId,
      callerId: currentUser.value!.id,
      caller: currentUser.value!.getBasicInfo,
      receiver: BasicUserModel.fromMemberModel(selectedUser.value),
      receiverId: selectedUser.value.id,
      callStatus: CallStatusType.ringing,
      callType: callType,
      createAt: now,
      messageId: now.millisecondsSinceEpoch.toString(),
    );
    // callModel.showIncomingCall();
    Get.find<CallController>().ringCallee(callModel);
  }

  void onCallCancel() {
    // Get.find<CallController>().onCallCancel();
  }

  void onTapEmoji() {
    if (isShowEmoji.isFalse) {
      FocusScope.of(Get.context!).unfocus();
      isShowEmoji.toggle();
    } else {
      isShowEmoji.toggle();
      //request focus
    }
  }

  void onCloseMedia() {
    isShowMedia.value = false;
    mediaList.clear();
  }

  void ontapBackground() {
    FocusScope.of(Get.context!).unfocus();

    if (isShowEmoji.isTrue) {
      isShowEmoji.value = false;
    } else if (isShowMedia.isTrue) {
      onCloseMedia();
    }
  }
}
