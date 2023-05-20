import 'package:json_annotation/json_annotation.dart';

import 'error_response.dart';

part 'base_data_response.g.dart';

@JsonSerializable()
class BaseDataResponse {
  @JsonKey(name: "error")
  ErrorResponse? error;

  BaseDataResponse({this.error});

  factory BaseDataResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseDataResponseToJson(this);
}
