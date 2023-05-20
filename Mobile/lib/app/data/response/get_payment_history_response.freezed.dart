// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'get_payment_history_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetPaymentHistoryResponse _$GetPaymentHistoryResponseFromJson(
    Map<String, dynamic> json) {
  return _GetPaymentHistoryResponse.fromJson(json);
}

/// @nodoc
mixin _$GetPaymentHistoryResponse {
  List<PaymentModel>? get data => throw _privateConstructorUsedError;
  Pagination? get pagination => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetPaymentHistoryResponseCopyWith<GetPaymentHistoryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetPaymentHistoryResponseCopyWith<$Res> {
  factory $GetPaymentHistoryResponseCopyWith(GetPaymentHistoryResponse value,
          $Res Function(GetPaymentHistoryResponse) then) =
      _$GetPaymentHistoryResponseCopyWithImpl<$Res, GetPaymentHistoryResponse>;
  @useResult
  $Res call({List<PaymentModel>? data, Pagination? pagination});
}

/// @nodoc
class _$GetPaymentHistoryResponseCopyWithImpl<$Res,
        $Val extends GetPaymentHistoryResponse>
    implements $GetPaymentHistoryResponseCopyWith<$Res> {
  _$GetPaymentHistoryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GetPaymentHistoryResponseCopyWith<$Res>
    implements $GetPaymentHistoryResponseCopyWith<$Res> {
  factory _$$_GetPaymentHistoryResponseCopyWith(
          _$_GetPaymentHistoryResponse value,
          $Res Function(_$_GetPaymentHistoryResponse) then) =
      __$$_GetPaymentHistoryResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<PaymentModel>? data, Pagination? pagination});
}

/// @nodoc
class __$$_GetPaymentHistoryResponseCopyWithImpl<$Res>
    extends _$GetPaymentHistoryResponseCopyWithImpl<$Res,
        _$_GetPaymentHistoryResponse>
    implements _$$_GetPaymentHistoryResponseCopyWith<$Res> {
  __$$_GetPaymentHistoryResponseCopyWithImpl(
      _$_GetPaymentHistoryResponse _value,
      $Res Function(_$_GetPaymentHistoryResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
    Object? pagination = freezed,
  }) {
    return _then(_$_GetPaymentHistoryResponse(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<PaymentModel>?,
      pagination: freezed == pagination
          ? _value.pagination
          : pagination // ignore: cast_nullable_to_non_nullable
              as Pagination?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GetPaymentHistoryResponse implements _GetPaymentHistoryResponse {
  const _$_GetPaymentHistoryResponse(
      {final List<PaymentModel>? data, this.pagination})
      : _data = data;

  factory _$_GetPaymentHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetPaymentHistoryResponseFromJson(json);

  final List<PaymentModel>? _data;
  @override
  List<PaymentModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Pagination? pagination;

  @override
  String toString() {
    return 'GetPaymentHistoryResponse(data: $data, pagination: $pagination)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetPaymentHistoryResponse &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_data), pagination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GetPaymentHistoryResponseCopyWith<_$_GetPaymentHistoryResponse>
      get copyWith => __$$_GetPaymentHistoryResponseCopyWithImpl<
          _$_GetPaymentHistoryResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetPaymentHistoryResponseToJson(
      this,
    );
  }
}

abstract class _GetPaymentHistoryResponse implements GetPaymentHistoryResponse {
  const factory _GetPaymentHistoryResponse(
      {final List<PaymentModel>? data,
      final Pagination? pagination}) = _$_GetPaymentHistoryResponse;

  factory _GetPaymentHistoryResponse.fromJson(Map<String, dynamic> json) =
      _$_GetPaymentHistoryResponse.fromJson;

  @override
  List<PaymentModel>? get data;
  @override
  Pagination? get pagination;
  @override
  @JsonKey(ignore: true)
  _$$_GetPaymentHistoryResponseCopyWith<_$_GetPaymentHistoryResponse>
      get copyWith => throw _privateConstructorUsedError;
}
