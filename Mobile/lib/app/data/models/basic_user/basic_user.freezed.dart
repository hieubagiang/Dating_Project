// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BasicUserModel _$BasicUserModelFromJson(Map<String, dynamic> json) {
  return _BasicUserModel.fromJson(json);
}

/// @nodoc
mixin _$BasicUserModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BasicUserModelCopyWith<BasicUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BasicUserModelCopyWith<$Res> {
  factory $BasicUserModelCopyWith(
          BasicUserModel value, $Res Function(BasicUserModel) then) =
      _$BasicUserModelCopyWithImpl<$Res, BasicUserModel>;
  @useResult
  $Res call({String id, String name, String avatar});
}

/// @nodoc
class _$BasicUserModelCopyWithImpl<$Res, $Val extends BasicUserModel>
    implements $BasicUserModelCopyWith<$Res> {
  _$BasicUserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_BasicUserModelCopyWith<$Res>
    implements $BasicUserModelCopyWith<$Res> {
  factory _$$_BasicUserModelCopyWith(
          _$_BasicUserModel value, $Res Function(_$_BasicUserModel) then) =
      __$$_BasicUserModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String avatar});
}

/// @nodoc
class __$$_BasicUserModelCopyWithImpl<$Res>
    extends _$BasicUserModelCopyWithImpl<$Res, _$_BasicUserModel>
    implements _$$_BasicUserModelCopyWith<$Res> {
  __$$_BasicUserModelCopyWithImpl(
      _$_BasicUserModel _value, $Res Function(_$_BasicUserModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? avatar = null,
  }) {
    return _then(_$_BasicUserModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_BasicUserModel extends _BasicUserModel {
  const _$_BasicUserModel(
      {required this.id, required this.name, required this.avatar})
      : super._();

  factory _$_BasicUserModel.fromJson(Map<String, dynamic> json) =>
      _$$_BasicUserModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String avatar;

  @override
  String toString() {
    return 'BasicUserModel(id: $id, name: $name, avatar: $avatar)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BasicUserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.avatar, avatar) || other.avatar == avatar));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, avatar);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BasicUserModelCopyWith<_$_BasicUserModel> get copyWith =>
      __$$_BasicUserModelCopyWithImpl<_$_BasicUserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BasicUserModelToJson(
      this,
    );
  }
}

abstract class _BasicUserModel extends BasicUserModel {
  const factory _BasicUserModel(
      {required final String id,
      required final String name,
      required final String avatar}) = _$_BasicUserModel;
  const _BasicUserModel._() : super._();

  factory _BasicUserModel.fromJson(Map<String, dynamic> json) =
      _$_BasicUserModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get avatar;
  @override
  @JsonKey(ignore: true)
  _$$_BasicUserModelCopyWith<_$_BasicUserModel> get copyWith =>
      throw _privateConstructorUsedError;
}
