import 'package:json_annotation/json_annotation.dart';

part 'notification_request.g.dart';

@JsonSerializable()
class NotificationRequest {
  NotificationRequest({
    this.title,
    this.body,
    this.sound,
    this.tag,
    this.contentAvailable = true,
    this.alert = true,
  });

  @JsonKey(name: 'title')
  final String? title;
  @JsonKey(name: 'body')
  final String? body;
  @JsonKey(name: 'sound')
  final String? sound;
  @JsonKey(name: 'tag')
  final String? tag;
  @JsonKey(name: 'content_available')
  final bool? contentAvailable;
  @JsonKey(name: 'alert')
  final bool? alert;

  NotificationRequest copyWith({
    String? title,
    String? body,
    String? sound,
    String? tag,
    bool? contentAvailable,
    bool? alert,
  }) =>
      NotificationRequest(
        title: title ?? this.title,
        body: body ?? this.body,
        sound: sound ?? this.sound,
        tag: tag ?? this.tag,
        contentAvailable: contentAvailable ?? this.contentAvailable,
        alert: alert ?? this.alert,
      );

  factory NotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$NotificationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationRequestToJson(this);

  @override
  String toString() {
    return 'NotificationRequest{title: $title, body: $body, sound: $sound, tag: $tag, contentAvailable: $contentAvailable, alert: $alert}';
  }
}
