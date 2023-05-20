import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/message_type_enum.dart';
import 'package:dating_app/app/data/models/call/call_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../enums/attachment_type.dart';
import 'attachment_model.dart';

part 'message_model.g.dart';

List<Attachment> customAttachmentFromJson(List<dynamic> json) {
  for (var e in json) {
    if (e is String) {
//old database format
      return [
        Attachment(
            fileName: e, url: e, fileSize: '', type: AttachmentType.image)
      ];
    }
  }
  return json.map((e) => Attachment.fromJson(e)).toList();
}

@JsonSerializable(explicitToJson: true)
class MessageModel {
  @JsonKey(name: 'message_id')
  final String? messageId;
  @JsonKey(name: 'sender_name')
  final String? senderName;
  @JsonKey(name: 'sender_id')
  final String? senderId;
  @JsonKey(name: 'message_type')
  final MessageType? messageType;
  @JsonKey(name: 'text')
  final String? text;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final File? profilePhoto;
  @JsonKey(name: 'attachments', fromJson: customAttachmentFromJson)
  final List<Attachment>? attachments;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;
  @JsonKey(name: 'call_model')
  final CallModel? callModel;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  MessageModel({
    required this.senderName,
    required this.senderId,
    required this.messageId,
    this.messageType,
    this.text,
    this.avatarUrl,
    this.profilePhoto,
    this.attachments = const [],
    required this.createAt,
    this.updateAt,
    this.callModel,
  }) : super();

  MessageModel copyWith({
    String? senderName,
    String? senderId,
    String? messageId,
    String? text,
    String? avatarUrl,
    DateTime? createAt,
    DateTime? updateAt,
    List<Attachment>? attachments,
    CallModel? callModel,
  }) =>
      MessageModel(
        senderName: senderName ?? this.senderName,
        senderId: senderId ?? this.senderId,
        messageId: messageId ?? this.messageId,
        text: text ?? this.text,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        attachments: attachments ?? this.attachments,
        createAt: createAt ?? this.createAt,
        updateAt: updateAt ?? this.updateAt,
        callModel: callModel ?? this.callModel,
      );

  factory MessageModel.firstMessage() {
    var now = DateTime.now();
    return MessageModel(
      senderName: FirebaseStorageConstants.admin,
      senderId: FirebaseStorageConstants.admin,
      messageId: now.millisecondsSinceEpoch.toString(),
      text: StringUtils.firstChatMessage,
      messageType: MessageType.system,
      createAt: now,
      updateAt: now,
    );
  }

  factory MessageModel.fromCallMessage(CallModel callModel) {
    var now = DateTime.now();
    return MessageModel(
      senderName: callModel.caller?.name ?? '',
      senderId: callModel.caller?.id ?? '',
      avatarUrl: callModel.caller?.avatar ?? '',
      messageId: callModel.messageId,
      messageType: MessageType.call,
      createAt: now,
      updateAt: now,
      callModel: callModel,
    );
  }

  factory MessageModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      MessageModel.fromJson(snapshot.data() ?? {});

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  String getMessage() {
    return isSystemMessage ? '$text'.tr : text ?? '';
  }

  String getLastMessageContent({required String? currentUserId}) {
    switch (messageType) {
      case MessageType.normal:
        if (text == 'you-are-connected') {
          return text?.tr ?? '';
        }
        if (attachments?.isNotEmpty ?? false) {
          return 'has_send_an_attachment'.tr;
        }
        return text ?? '';
      case MessageType.pending:
        return text ?? '';
      case MessageType.system:
        return '$text'.tr;
      case MessageType.call:
        return callModel?.callerId == currentUserId
            ? 'you_haved_called'
                .trParams({'name': callModel?.receiver?.name ?? ''})
            : 'you_haved_been_called'
                .trParams({'name': callModel?.caller?.name ?? ''});
        '';
      default:
        if (attachments?.isNotEmpty ?? false) {
          return 'has_send_an_attachment'.tr;
        }
        return text ?? '';
    }
  }

  String getLastMessage({required String? currentUserId}) {
    final prefix = messageType != MessageType.normal
        ? ''
        : senderId == currentUserId
            ? 'you'.tr
            : '';
    final suffix = DateTimeUtils.getStringTimeAgo(updateAt, Pattern.ddMMyyyy);
    return '${prefix.isNotEmpty ? '$prefix:' : ''} ${getLastMessageContent(currentUserId: currentUserId)} - $suffix';
  }

  bool get isSystemMessage => messageType == MessageType.system;

  Map<String, dynamic> toJson() => _$MessageModelToJson(this);

  @override
  String toString() {
    return 'MessageModel{messageId: $messageId, senderName: $senderName, senderId: $senderId, messageType: $messageType, text: $text, avatarUrl: $avatarUrl, profilePhoto: $profilePhoto, attachments: $attachments}';
  }
}
