// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_package_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SubscriptionPackageModel _$SubscriptionPackageModelFromJson(
    Map<String, dynamic> json) {
  return _SubscriptionPackageModel.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionPackageModel {
  @JsonKey(name: "duration_in_days")
  int? get durationInDays => throw _privateConstructorUsedError;
  int? get price => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SubscriptionPackageModelCopyWith<SubscriptionPackageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionPackageModelCopyWith<$Res> {
  factory $SubscriptionPackageModelCopyWith(SubscriptionPackageModel value,
          $Res Function(SubscriptionPackageModel) then) =
      _$SubscriptionPackageModelCopyWithImpl<$Res, SubscriptionPackageModel>;
  @useResult
  $Res call(
      {@JsonKey(name: "duration_in_days") int? durationInDays,
      int? price,
      String? name,
      String? slug});
}

/// @nodoc
class _$SubscriptionPackageModelCopyWithImpl<$Res,
        $Val extends SubscriptionPackageModel>
    implements $SubscriptionPackageModelCopyWith<$Res> {
  _$SubscriptionPackageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationInDays = freezed,
    Object? price = freezed,
    Object? name = freezed,
    Object? slug = freezed,
  }) {
    return _then(_value.copyWith(
      durationInDays: freezed == durationInDays
          ? _value.durationInDays
          : durationInDays // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SubscriptionPackageModelCopyWith<$Res>
    implements $SubscriptionPackageModelCopyWith<$Res> {
  factory _$$_SubscriptionPackageModelCopyWith(
          _$_SubscriptionPackageModel value,
          $Res Function(_$_SubscriptionPackageModel) then) =
      __$$_SubscriptionPackageModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "duration_in_days") int? durationInDays,
      int? price,
      String? name,
      String? slug});
}

/// @nodoc
class __$$_SubscriptionPackageModelCopyWithImpl<$Res>
    extends _$SubscriptionPackageModelCopyWithImpl<$Res,
        _$_SubscriptionPackageModel>
    implements _$$_SubscriptionPackageModelCopyWith<$Res> {
  __$$_SubscriptionPackageModelCopyWithImpl(_$_SubscriptionPackageModel _value,
      $Res Function(_$_SubscriptionPackageModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? durationInDays = freezed,
    Object? price = freezed,
    Object? name = freezed,
    Object? slug = freezed,
  }) {
    return _then(_$_SubscriptionPackageModel(
      durationInDays: freezed == durationInDays
          ? _value.durationInDays
          : durationInDays // ignore: cast_nullable_to_non_nullable
              as int?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SubscriptionPackageModel extends _SubscriptionPackageModel {
  const _$_SubscriptionPackageModel(
      {@JsonKey(name: "duration_in_days") this.durationInDays,
      this.price,
      this.name,
      this.slug})
      : super._();

  factory _$_SubscriptionPackageModel.fromJson(Map<String, dynamic> json) =>
      _$$_SubscriptionPackageModelFromJson(json);

  @override
  @JsonKey(name: "duration_in_days")
  final int? durationInDays;
  @override
  final int? price;
  @override
  final String? name;
  @override
  final String? slug;

  @override
  String toString() {
    return 'SubscriptionPackageModel(durationInDays: $durationInDays, price: $price, name: $name, slug: $slug)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SubscriptionPackageModel &&
            (identical(other.durationInDays, durationInDays) ||
                other.durationInDays == durationInDays) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, durationInDays, price, name, slug);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SubscriptionPackageModelCopyWith<_$_SubscriptionPackageModel>
      get copyWith => __$$_SubscriptionPackageModelCopyWithImpl<
          _$_SubscriptionPackageModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SubscriptionPackageModelToJson(
      this,
    );
  }
}

abstract class _SubscriptionPackageModel extends SubscriptionPackageModel {
  const factory _SubscriptionPackageModel(
      {@JsonKey(name: "duration_in_days") final int? durationInDays,
      final int? price,
      final String? name,
      final String? slug}) = _$_SubscriptionPackageModel;
  const _SubscriptionPackageModel._() : super._();

  factory _SubscriptionPackageModel.fromJson(Map<String, dynamic> json) =
      _$_SubscriptionPackageModel.fromJson;

  @override
  @JsonKey(name: "duration_in_days")
  int? get durationInDays;
  @override
  int? get price;
  @override
  String? get name;
  @override
  String? get slug;
  @override
  @JsonKey(ignore: true)
  _$$_SubscriptionPackageModelCopyWith<_$_SubscriptionPackageModel>
      get copyWith => throw _privateConstructorUsedError;
}
