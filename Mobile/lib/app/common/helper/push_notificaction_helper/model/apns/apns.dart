import 'dart:convert';

import 'apns_fcm_options.dart';

class Apns {
  Apns({
    this.headers,
    this.payload,
    this.fcmOptions,
  });

  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? payload;
  final ApnsFcmOptions? fcmOptions;

  Apns copyWith({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? payload,
    ApnsFcmOptions? fcmOptions,
  }) =>
      Apns(
        headers: headers ?? this.headers,
        payload: payload ?? this.payload,
        fcmOptions: fcmOptions ?? this.fcmOptions,
      );

  factory Apns.fromRawJson(String str) => Apns.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Apns.fromJson(Map<String, dynamic> json) => Apns(
        headers: jsonDecode(json["headers"]),
        payload: jsonDecode(json["payload"]),
        fcmOptions: ApnsFcmOptions.fromJson(json["fcm_options"]),
      );

  Map<String, dynamic> toJson() => {
        "headers": jsonEncode(headers),
        "payload": jsonEncode(payload),
        "fcm_options": fcmOptions?.toJson(),
      };
}
