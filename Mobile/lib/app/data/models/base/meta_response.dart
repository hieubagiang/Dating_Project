import 'package:json_annotation/json_annotation.dart';

part 'meta_response.g.dart';

@JsonSerializable()
class MetaResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;

  MetaResponse({this.status, this.message});

  factory MetaResponse.fromJson(Map<String, dynamic> json) =>
      _$MetaResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MetaResponseToJson(this);
}
