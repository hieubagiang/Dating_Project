// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentModel _$PaymentModelFromJson(Map<String, dynamic> json) {
  return _PaymentModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentModel {
  String? get paymentId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  PaymentStatusType? get status => throw _privateConstructorUsedError;
  String? get paymentMethod => throw _privateConstructorUsedError;
  String? get transactionId => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get createAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get updateAt => throw _privateConstructorUsedError;
  SubscriptionPackageModel? get subscriptionPackage =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentModelCopyWith<PaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentModelCopyWith<$Res> {
  factory $PaymentModelCopyWith(
          PaymentModel value, $Res Function(PaymentModel) then) =
      _$PaymentModelCopyWithImpl<$Res, PaymentModel>;
  @useResult
  $Res call(
      {String? paymentId,
      String? userId,
      PaymentStatusType? status,
      String? paymentMethod,
      String? transactionId,
      DateTime? createdAt,
      DateTime? createAt,
      DateTime? updatedAt,
      DateTime? updateAt,
      SubscriptionPackageModel? subscriptionPackage});

  $SubscriptionPackageModelCopyWith<$Res>? get subscriptionPackage;
}

/// @nodoc
class _$PaymentModelCopyWithImpl<$Res, $Val extends PaymentModel>
    implements $PaymentModelCopyWith<$Res> {
  _$PaymentModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = freezed,
    Object? userId = freezed,
    Object? status = freezed,
    Object? paymentMethod = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? createAt = freezed,
    Object? updatedAt = freezed,
    Object? updateAt = freezed,
    Object? subscriptionPackage = freezed,
  }) {
    return _then(_value.copyWith(
      paymentId: freezed == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatusType?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionPackage: freezed == subscriptionPackage
          ? _value.subscriptionPackage
          : subscriptionPackage // ignore: cast_nullable_to_non_nullable
              as SubscriptionPackageModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SubscriptionPackageModelCopyWith<$Res>? get subscriptionPackage {
    if (_value.subscriptionPackage == null) {
      return null;
    }

    return $SubscriptionPackageModelCopyWith<$Res>(_value.subscriptionPackage!,
        (value) {
      return _then(_value.copyWith(subscriptionPackage: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PaymentModelCopyWith<$Res>
    implements $PaymentModelCopyWith<$Res> {
  factory _$$_PaymentModelCopyWith(
          _$_PaymentModel value, $Res Function(_$_PaymentModel) then) =
      __$$_PaymentModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? paymentId,
      String? userId,
      PaymentStatusType? status,
      String? paymentMethod,
      String? transactionId,
      DateTime? createdAt,
      DateTime? createAt,
      DateTime? updatedAt,
      DateTime? updateAt,
      SubscriptionPackageModel? subscriptionPackage});

  @override
  $SubscriptionPackageModelCopyWith<$Res>? get subscriptionPackage;
}

/// @nodoc
class __$$_PaymentModelCopyWithImpl<$Res>
    extends _$PaymentModelCopyWithImpl<$Res, _$_PaymentModel>
    implements _$$_PaymentModelCopyWith<$Res> {
  __$$_PaymentModelCopyWithImpl(
      _$_PaymentModel _value, $Res Function(_$_PaymentModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paymentId = freezed,
    Object? userId = freezed,
    Object? status = freezed,
    Object? paymentMethod = freezed,
    Object? transactionId = freezed,
    Object? createdAt = freezed,
    Object? createAt = freezed,
    Object? updatedAt = freezed,
    Object? updateAt = freezed,
    Object? subscriptionPackage = freezed,
  }) {
    return _then(_$_PaymentModel(
      paymentId: freezed == paymentId
          ? _value.paymentId
          : paymentId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PaymentStatusType?,
      paymentMethod: freezed == paymentMethod
          ? _value.paymentMethod
          : paymentMethod // ignore: cast_nullable_to_non_nullable
              as String?,
      transactionId: freezed == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      subscriptionPackage: freezed == subscriptionPackage
          ? _value.subscriptionPackage
          : subscriptionPackage // ignore: cast_nullable_to_non_nullable
              as SubscriptionPackageModel?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_PaymentModel extends _PaymentModel {
  _$_PaymentModel(
      {this.paymentId,
      this.userId,
      this.status,
      this.paymentMethod,
      this.transactionId,
      this.createdAt,
      this.createAt,
      this.updatedAt,
      this.updateAt,
      this.subscriptionPackage})
      : super._();

  factory _$_PaymentModel.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentModelFromJson(json);

  @override
  final String? paymentId;
  @override
  final String? userId;
  @override
  final PaymentStatusType? status;
  @override
  final String? paymentMethod;
  @override
  final String? transactionId;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? createAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? updateAt;
  @override
  final SubscriptionPackageModel? subscriptionPackage;

  @override
  String toString() {
    return 'PaymentModel(paymentId: $paymentId, userId: $userId, status: $status, paymentMethod: $paymentMethod, transactionId: $transactionId, createdAt: $createdAt, createAt: $createAt, updatedAt: $updatedAt, updateAt: $updateAt, subscriptionPackage: $subscriptionPackage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentModel &&
            (identical(other.paymentId, paymentId) ||
                other.paymentId == paymentId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt) &&
            (identical(other.subscriptionPackage, subscriptionPackage) ||
                other.subscriptionPackage == subscriptionPackage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      paymentId,
      userId,
      status,
      paymentMethod,
      transactionId,
      createdAt,
      createAt,
      updatedAt,
      updateAt,
      subscriptionPackage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentModelCopyWith<_$_PaymentModel> get copyWith =>
      __$$_PaymentModelCopyWithImpl<_$_PaymentModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentModelToJson(
      this,
    );
  }
}

abstract class _PaymentModel extends PaymentModel {
  factory _PaymentModel(
      {final String? paymentId,
      final String? userId,
      final PaymentStatusType? status,
      final String? paymentMethod,
      final String? transactionId,
      final DateTime? createdAt,
      final DateTime? createAt,
      final DateTime? updatedAt,
      final DateTime? updateAt,
      final SubscriptionPackageModel? subscriptionPackage}) = _$_PaymentModel;
  _PaymentModel._() : super._();

  factory _PaymentModel.fromJson(Map<String, dynamic> json) =
      _$_PaymentModel.fromJson;

  @override
  String? get paymentId;
  @override
  String? get userId;
  @override
  PaymentStatusType? get status;
  @override
  String? get paymentMethod;
  @override
  String? get transactionId;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get createAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get updateAt;
  @override
  SubscriptionPackageModel? get subscriptionPackage;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentModelCopyWith<_$_PaymentModel> get copyWith =>
      throw _privateConstructorUsedError;
}
