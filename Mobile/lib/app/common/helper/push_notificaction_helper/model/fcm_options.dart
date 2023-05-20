import 'dart:convert';

class FcmOptions {
  FcmOptions({
    this.analyticsLabel,
  });

  final String? analyticsLabel;

  FcmOptions copyWith({
    String? analyticsLabel,
  }) =>
      FcmOptions(
        analyticsLabel: analyticsLabel ?? this.analyticsLabel,
      );

  factory FcmOptions.fromRawJson(String str) =>
      FcmOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcmOptions.fromJson(Map<String, dynamic> json) => FcmOptions(
        analyticsLabel: json["analytics_label"],
      );

  Map<String, dynamic> toJson() => {
        "analytics_label": analyticsLabel,
      };
}
