import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../common/utils/date_time.dart';
import 'member_model.dart';
import 'message_model.dart';

part 'channel_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ChannelModel {
  ChannelModel({
    this.channelId,
    this.members,
    this.memberIds,
    this.messages,
    this.lastMessage,
    this.createAt,
    this.updateAt,
  });

  @JsonKey(name: 'channel_id')
  final String? channelId;
  @JsonKey(name: 'members')
  final List<MemberModel>? members;
  @JsonKey(name: 'member_ids')
  final List<String>? memberIds;
  @JsonKey(name: 'messages')
  final List<MessageModel>? messages;
  @JsonKey(name: 'last_message')
  final MessageModel? lastMessage;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  ChannelModel copyWith({
    String? channelId,
    List<MemberModel>? members,
    List<MessageModel>? messages,
    DateTime? createAt,
    DateTime? updateAt,
  }) =>
      ChannelModel(
          channelId: channelId ?? this.channelId,
          members: members ?? this.members,
          messages: messages ?? this.messages,
          createAt: createAt ?? this.createAt);

  factory ChannelModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      ChannelModel.fromJson(snapshot.data() ?? {});

  factory ChannelModel.fromJson(Map<String, dynamic> json) =>
      _$ChannelModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChannelModelToJson(this)..removeNulls();
}
