// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BaseErrorResponse _$BaseErrorResponseFromJson(Map<String, dynamic> json) {
  return _BaseErrorResponse.fromJson(json);
}

/// @nodoc
mixin _$BaseErrorResponse {
  String? get errorMessage => throw _privateConstructorUsedError;
  bool? get status => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseErrorResponseCopyWith<BaseErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseErrorResponseCopyWith<$Res> {
  factory $BaseErrorResponseCopyWith(
          BaseErrorResponse value, $Res Function(BaseErrorResponse) then) =
      _$BaseErrorResponseCopyWithImpl<$Res, BaseErrorResponse>;
  @useResult
  $Res call({String? errorMessage, bool? status, String? code});
}

/// @nodoc
class _$BaseErrorResponseCopyWithImpl<$Res, $Val extends BaseErrorResponse>
    implements $BaseErrorResponseCopyWith<$Res> {
  _$BaseErrorResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? status = freezed,
    Object? code = freezed,
  }) {
    return _then(_value.copyWith(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BaseErrorResponseCopyWith<$Res>
    implements $BaseErrorResponseCopyWith<$Res> {
  factory _$$_BaseErrorResponseCopyWith(_$_BaseErrorResponse value,
          $Res Function(_$_BaseErrorResponse) then) =
      __$$_BaseErrorResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? errorMessage, bool? status, String? code});
}

/// @nodoc
class __$$_BaseErrorResponseCopyWithImpl<$Res>
    extends _$BaseErrorResponseCopyWithImpl<$Res, _$_BaseErrorResponse>
    implements _$$_BaseErrorResponseCopyWith<$Res> {
  __$$_BaseErrorResponseCopyWithImpl(
      _$_BaseErrorResponse _value, $Res Function(_$_BaseErrorResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? errorMessage = freezed,
    Object? status = freezed,
    Object? code = freezed,
  }) {
    return _then(_$_BaseErrorResponse(
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as bool?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_BaseErrorResponse extends _BaseErrorResponse {
  const _$_BaseErrorResponse({this.errorMessage, this.status, this.code})
      : super._();

  factory _$_BaseErrorResponse.fromJson(Map<String, dynamic> json) =>
      _$$_BaseErrorResponseFromJson(json);

  @override
  final String? errorMessage;
  @override
  final bool? status;
  @override
  final String? code;

  @override
  String toString() {
    return 'BaseErrorResponse(errorMessage: $errorMessage, status: $status, code: $code)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BaseErrorResponse &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.code, code) || other.code == code));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, errorMessage, status, code);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BaseErrorResponseCopyWith<_$_BaseErrorResponse> get copyWith =>
      __$$_BaseErrorResponseCopyWithImpl<_$_BaseErrorResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BaseErrorResponseToJson(
      this,
    );
  }
}

abstract class _BaseErrorResponse extends BaseErrorResponse {
  const factory _BaseErrorResponse(
      {final String? errorMessage,
      final bool? status,
      final String? code}) = _$_BaseErrorResponse;
  const _BaseErrorResponse._() : super._();

  factory _BaseErrorResponse.fromJson(Map<String, dynamic> json) =
      _$_BaseErrorResponse.fromJson;

  @override
  String? get errorMessage;
  @override
  bool? get status;
  @override
  String? get code;
  @override
  @JsonKey(ignore: true)
  _$$_BaseErrorResponseCopyWith<_$_BaseErrorResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
