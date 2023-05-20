// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentRequest _$PaymentRequestFromJson(Map<String, dynamic> json) {
  return _PaymentRequest.fromJson(json);
}

/// @nodoc
mixin _$PaymentRequest {
  @JsonKey(name: "user_id")
  String? get userId => throw _privateConstructorUsedError;
  @JsonKey(name: "premium_package")
  String? get premiumPackage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentRequestCopyWith<PaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentRequestCopyWith<$Res> {
  factory $PaymentRequestCopyWith(
          PaymentRequest value, $Res Function(PaymentRequest) then) =
      _$PaymentRequestCopyWithImpl<$Res, PaymentRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "user_id") String? userId,
      @JsonKey(name: "premium_package") String? premiumPackage});
}

/// @nodoc
class _$PaymentRequestCopyWithImpl<$Res, $Val extends PaymentRequest>
    implements $PaymentRequestCopyWith<$Res> {
  _$PaymentRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? premiumPackage = freezed,
  }) {
    return _then(_value.copyWith(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      premiumPackage: freezed == premiumPackage
          ? _value.premiumPackage
          : premiumPackage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentRequestCopyWith<$Res>
    implements $PaymentRequestCopyWith<$Res> {
  factory _$$_PaymentRequestCopyWith(
          _$_PaymentRequest value, $Res Function(_$_PaymentRequest) then) =
      __$$_PaymentRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user_id") String? userId,
      @JsonKey(name: "premium_package") String? premiumPackage});
}

/// @nodoc
class __$$_PaymentRequestCopyWithImpl<$Res>
    extends _$PaymentRequestCopyWithImpl<$Res, _$_PaymentRequest>
    implements _$$_PaymentRequestCopyWith<$Res> {
  __$$_PaymentRequestCopyWithImpl(
      _$_PaymentRequest _value, $Res Function(_$_PaymentRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? premiumPackage = freezed,
  }) {
    return _then(_$_PaymentRequest(
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      premiumPackage: freezed == premiumPackage
          ? _value.premiumPackage
          : premiumPackage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentRequest implements _PaymentRequest {
  const _$_PaymentRequest(
      {@JsonKey(name: "user_id") this.userId,
      @JsonKey(name: "premium_package") this.premiumPackage});

  factory _$_PaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentRequestFromJson(json);

  @override
  @JsonKey(name: "user_id")
  final String? userId;
  @override
  @JsonKey(name: "premium_package")
  final String? premiumPackage;

  @override
  String toString() {
    return 'PaymentRequest(userId: $userId, premiumPackage: $premiumPackage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentRequest &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.premiumPackage, premiumPackage) ||
                other.premiumPackage == premiumPackage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, premiumPackage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentRequestCopyWith<_$_PaymentRequest> get copyWith =>
      __$$_PaymentRequestCopyWithImpl<_$_PaymentRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentRequestToJson(
      this,
    );
  }
}

abstract class _PaymentRequest implements PaymentRequest {
  const factory _PaymentRequest(
          {@JsonKey(name: "user_id") final String? userId,
          @JsonKey(name: "premium_package") final String? premiumPackage}) =
      _$_PaymentRequest;

  factory _PaymentRequest.fromJson(Map<String, dynamic> json) =
      _$_PaymentRequest.fromJson;

  @override
  @JsonKey(name: "user_id")
  String? get userId;
  @override
  @JsonKey(name: "premium_package")
  String? get premiumPackage;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentRequestCopyWith<_$_PaymentRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
