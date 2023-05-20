import 'package:dating_app/app/data/enums/message_type_enum.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/chat/message_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'push_notification_data_request.g.dart';

@JsonSerializable(explicitToJson: true)
class PushNotificationDataRequest {
  PushNotificationDataRequest(
      {this.title,
      this.body,
      this.clickAction,
      this.tag,
      this.messageModel,
      this.messageType,
      this.channel});

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'body')
  final String? body;
  @JsonKey(name: 'click_action')
  final String? clickAction;
  @JsonKey(name: 'tag')
  final String? tag;
  @JsonKey(name: 'message_model')
  final MessageModel? messageModel;
  @JsonKey(name: 'type')
  final MessageType? messageType;
  @JsonKey(name: 'channel')
  final ChannelModel? channel;

  PushNotificationDataRequest copyWith({
    String? title,
    String? body,
    int? priority,
    String? clickAction,
    String? tag,
    MessageModel? messageModel,
  }) =>
      PushNotificationDataRequest(
        title: title ?? this.title,
        body: body ?? this.body,
        clickAction: clickAction ?? this.clickAction,
        tag: tag ?? this.tag,
      );

  factory PushNotificationDataRequest.fromJson(Map<String, dynamic> json) =>
      _$PushNotificationDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PushNotificationDataRequestToJson(this);

  @override
  String toString() {
    return 'PushNotificationDataRequest{title: $title, body: $body, clickAction: $clickAction, tag: $tag, messageModel: $messageModel}';
  }
}
