import 'dart:convert';

class MessageNotification {
  MessageNotification({
    this.title,
    this.body,
    this.image,
    this.sound,
    this.tag,
  });

  final String? title;
  final String? body;
  final String? image;
  final String? sound;
  final String? tag;

  MessageNotification copyWith({
    String? title,
    String? body,
    String? image,
    String? sound,
    String? tag,
  }) =>
      MessageNotification(
        title: title ?? this.title,
        body: body ?? this.body,
        image: image ?? this.image,
        sound: sound ?? this.sound,
        tag: tag ?? this.tag,
      );

  factory MessageNotification.fromRawJson(String str) =>
      MessageNotification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MessageNotification.fromJson(Map<String, dynamic> json) =>
      MessageNotification(
        title: json["title"],
        body: json["body"],
        image: json["images"],
        sound: json["sound"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "body": body,
        "images": image,
        "sound": sound,
        "tag": tag
      };
}
