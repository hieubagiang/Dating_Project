// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_payment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CreatePaymentResponse _$CreatePaymentResponseFromJson(
    Map<String, dynamic> json) {
  return _CreatePaymentResponse.fromJson(json);
}

/// @nodoc
mixin _$CreatePaymentResponse {
  @JsonKey(name: "payment_model")
  PaymentModel? get paymentModel => throw _privateConstructorUsedError;
  @JsonKey(name: "payment_url")
  String? get paymentUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CreatePaymentResponseCopyWith<CreatePaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatePaymentResponseCopyWith<$Res> {
  factory $CreatePaymentResponseCopyWith(CreatePaymentResponse value,
          $Res Function(CreatePaymentResponse) then) =
      _$CreatePaymentResponseCopyWithImpl<$Res, CreatePaymentResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: "payment_model") PaymentModel? paymentModel,
      @JsonKey(name: "payment_url") String? paymentUrl});

  $PaymentModelCopyWith<$Res>? get paymentModel;
}

/// @nodoc
class _$CreatePaymentResponseCopyWithImpl<$Res,
        $Val extends CreatePaymentResponse>
    implements $CreatePaymentResponseCopyWith<$Res> {
  _$CreatePaymentResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentModel = freezed,
    Object? paymentUrl = freezed,
  }) {
    return _then(_value.copyWith(
      paymentModel: freezed == paymentModel
          ? _value.paymentModel
          : paymentModel // ignore: cast_nullable_to_non_nullable
              as PaymentModel?,
      paymentUrl: freezed == paymentUrl
          ? _value.paymentUrl
          : paymentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentModelCopyWith<$Res>? get paymentModel {
    if (_value.paymentModel == null) {
      return null;
    }

    return $PaymentModelCopyWith<$Res>(_value.paymentModel!, (value) {
      return _then(_value.copyWith(paymentModel: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CreatePaymentResponseCopyWith<$Res>
    implements $CreatePaymentResponseCopyWith<$Res> {
  factory _$$_CreatePaymentResponseCopyWith(_$_CreatePaymentResponse value,
          $Res Function(_$_CreatePaymentResponse) then) =
      __$$_CreatePaymentResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "payment_model") PaymentModel? paymentModel,
      @JsonKey(name: "payment_url") String? paymentUrl});

  @override
  $PaymentModelCopyWith<$Res>? get paymentModel;
}

/// @nodoc
class __$$_CreatePaymentResponseCopyWithImpl<$Res>
    extends _$CreatePaymentResponseCopyWithImpl<$Res, _$_CreatePaymentResponse>
    implements _$$_CreatePaymentResponseCopyWith<$Res> {
  __$$_CreatePaymentResponseCopyWithImpl(_$_CreatePaymentResponse _value,
      $Res Function(_$_CreatePaymentResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentModel = freezed,
    Object? paymentUrl = freezed,
  }) {
    return _then(_$_CreatePaymentResponse(
      paymentModel: freezed == paymentModel
          ? _value.paymentModel
          : paymentModel // ignore: cast_nullable_to_non_nullable
              as PaymentModel?,
      paymentUrl: freezed == paymentUrl
          ? _value.paymentUrl
          : paymentUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CreatePaymentResponse implements _CreatePaymentResponse {
  const _$_CreatePaymentResponse(
      {@JsonKey(name: "payment_model") this.paymentModel,
      @JsonKey(name: "payment_url") this.paymentUrl});

  factory _$_CreatePaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$$_CreatePaymentResponseFromJson(json);

  @override
  @JsonKey(name: "payment_model")
  final PaymentModel? paymentModel;
  @override
  @JsonKey(name: "payment_url")
  final String? paymentUrl;

  @override
  String toString() {
    return 'CreatePaymentResponse(paymentModel: $paymentModel, paymentUrl: $paymentUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CreatePaymentResponse &&
            (identical(other.paymentModel, paymentModel) ||
                other.paymentModel == paymentModel) &&
            (identical(other.paymentUrl, paymentUrl) ||
                other.paymentUrl == paymentUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paymentModel, paymentUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CreatePaymentResponseCopyWith<_$_CreatePaymentResponse> get copyWith =>
      __$$_CreatePaymentResponseCopyWithImpl<_$_CreatePaymentResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CreatePaymentResponseToJson(
      this,
    );
  }
}

abstract class _CreatePaymentResponse implements CreatePaymentResponse {
  const factory _CreatePaymentResponse(
          {@JsonKey(name: "payment_model") final PaymentModel? paymentModel,
          @JsonKey(name: "payment_url") final String? paymentUrl}) =
      _$_CreatePaymentResponse;

  factory _CreatePaymentResponse.fromJson(Map<String, dynamic> json) =
      _$_CreatePaymentResponse.fromJson;

  @override
  @JsonKey(name: "payment_model")
  PaymentModel? get paymentModel;
  @override
  @JsonKey(name: "payment_url")
  String? get paymentUrl;
  @override
  @JsonKey(ignore: true)
  _$$_CreatePaymentResponseCopyWith<_$_CreatePaymentResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
