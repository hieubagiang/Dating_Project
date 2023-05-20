import 'dart:convert';

class AndroidFcmOptions {
  AndroidFcmOptions({
    this.analyticsLabel,
  });

  final String? analyticsLabel;

  AndroidFcmOptions copyWith({
    String? analyticsLabel,
  }) =>
      AndroidFcmOptions(
        analyticsLabel: analyticsLabel ?? this.analyticsLabel,
      );

  factory AndroidFcmOptions.fromRawJson(String str) =>
      AndroidFcmOptions.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AndroidFcmOptions.fromJson(Map<String, dynamic> json) =>
      AndroidFcmOptions(
        analyticsLabel: json["analytics_label"],
      );

  Map<String, dynamic> toJson() => {
        "analytics_label": analyticsLabel,
      };
}
