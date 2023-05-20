import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_data.dart';

part 'base_error.freezed.dart';
part 'base_error.g.dart';

@freezed
@freezed
class BaseErrorResponse with _$BaseErrorResponse {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory BaseErrorResponse({
    final String? errorMessage,
    final bool? status,
    final String? code,
  }) = _BaseErrorResponse;
  const BaseErrorResponse._();
  factory BaseErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseErrorResponseFromJson(json);

  factory BaseErrorResponse.fromBaseData(BaseData baseData) =>
      BaseErrorResponse(
        errorMessage: baseData.errorMessage,
        status: baseData.status,
        code: baseData.code,
      );

  factory BaseErrorResponse.defaultError() => const BaseErrorResponse(
        errorMessage: 'Something went wrong',
        status: false,
        code: '500',
      );
}
