import 'dart:convert';

class WebPushFcmOptions {
  WebPushFcmOptions({
    this.link,
    this.analyticsLabel,
  });

  final String? link;
  final String? analyticsLabel;

  WebPushFcmOptions copyWith({
    String? link,
    String? analyticsLabel,
  }) =>
      WebPushFcmOptions(
        link: link ?? this.link,
        analyticsLabel: analyticsLabel ?? this.analyticsLabel,
      );

  factory WebPushFcmOptions.fromRawJson(String str) =>
      WebPushFcmOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WebPushFcmOptions.fromJson(Map<String, dynamic> json) =>
      WebPushFcmOptions(
        link: json["link"],
        analyticsLabel: json["analytics_label"],
      );

  Map<String, dynamic> toJson() => {
        "link": link,
        "analytics_label": analyticsLabel,
      };
}
