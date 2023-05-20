import 'dart:convert';

class ApnsFcmOptions {
  ApnsFcmOptions({
    this.analyticsLabel,
    this.image,
  });

  final String? analyticsLabel;
  final String? image;

  ApnsFcmOptions copyWith({
    String? analyticsLabel,
    String? image,
  }) =>
      ApnsFcmOptions(
        analyticsLabel: analyticsLabel ?? this.analyticsLabel,
        image: image ?? this.image,
      );

  factory ApnsFcmOptions.fromRawJson(String str) =>
      ApnsFcmOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApnsFcmOptions.fromJson(Map<String, dynamic> json) => ApnsFcmOptions(
        analyticsLabel: json["analytics_label"],
        image: json["images"],
      );

  Map<String, dynamic> toJson() => {
        "analytics_label": analyticsLabel,
        "images": image,
      };
}
