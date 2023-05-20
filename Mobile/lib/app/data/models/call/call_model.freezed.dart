// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'call_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CallModel _$CallModelFromJson(Map<String, dynamic> json) {
  return _CallModel.fromJson(json);
}

/// @nodoc
mixin _$CallModel {
  String? get callId => throw _privateConstructorUsedError;
  String? get channelId => throw _privateConstructorUsedError;
  String? get callerId => throw _privateConstructorUsedError;
  String? get messageId => throw _privateConstructorUsedError;
  BasicUserModel? get caller => throw _privateConstructorUsedError;
  String? get receiverId => throw _privateConstructorUsedError;
  BasicUserModel? get receiver => throw _privateConstructorUsedError;
  CallStatusType? get callStatus => throw _privateConstructorUsedError;
  CallType? get callType => throw _privateConstructorUsedError;
  DateTime? get startTime => throw _privateConstructorUsedError;
  DateTime? get endTime => throw _privateConstructorUsedError;
  DateTime? get createAt => throw _privateConstructorUsedError;
  DateTime? get updateAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CallModelCopyWith<CallModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CallModelCopyWith<$Res> {
  factory $CallModelCopyWith(CallModel value, $Res Function(CallModel) then) =
      _$CallModelCopyWithImpl<$Res, CallModel>;
  @useResult
  $Res call(
      {String? callId,
      String? channelId,
      String? callerId,
      String? messageId,
      BasicUserModel? caller,
      String? receiverId,
      BasicUserModel? receiver,
      CallStatusType? callStatus,
      CallType? callType,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? createAt,
      DateTime? updateAt});

  $BasicUserModelCopyWith<$Res>? get caller;
  $BasicUserModelCopyWith<$Res>? get receiver;
}

/// @nodoc
class _$CallModelCopyWithImpl<$Res, $Val extends CallModel>
    implements $CallModelCopyWith<$Res> {
  _$CallModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = freezed,
    Object? channelId = freezed,
    Object? callerId = freezed,
    Object? messageId = freezed,
    Object? caller = freezed,
    Object? receiverId = freezed,
    Object? receiver = freezed,
    Object? callStatus = freezed,
    Object? callType = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_value.copyWith(
      callId: freezed == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      callerId: freezed == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      caller: freezed == caller
          ? _value.caller
          : caller // ignore: cast_nullable_to_non_nullable
              as BasicUserModel?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiver: freezed == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as BasicUserModel?,
      callStatus: freezed == callStatus
          ? _value.callStatus
          : callStatus // ignore: cast_nullable_to_non_nullable
              as CallStatusType?,
      callType: freezed == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BasicUserModelCopyWith<$Res>? get caller {
    if (_value.caller == null) {
      return null;
    }

    return $BasicUserModelCopyWith<$Res>(_value.caller!, (value) {
      return _then(_value.copyWith(caller: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $BasicUserModelCopyWith<$Res>? get receiver {
    if (_value.receiver == null) {
      return null;
    }

    return $BasicUserModelCopyWith<$Res>(_value.receiver!, (value) {
      return _then(_value.copyWith(receiver: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CallModelCopyWith<$Res> implements $CallModelCopyWith<$Res> {
  factory _$$_CallModelCopyWith(
          _$_CallModel value, $Res Function(_$_CallModel) then) =
      __$$_CallModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? callId,
      String? channelId,
      String? callerId,
      String? messageId,
      BasicUserModel? caller,
      String? receiverId,
      BasicUserModel? receiver,
      CallStatusType? callStatus,
      CallType? callType,
      DateTime? startTime,
      DateTime? endTime,
      DateTime? createAt,
      DateTime? updateAt});

  @override
  $BasicUserModelCopyWith<$Res>? get caller;
  @override
  $BasicUserModelCopyWith<$Res>? get receiver;
}

/// @nodoc
class __$$_CallModelCopyWithImpl<$Res>
    extends _$CallModelCopyWithImpl<$Res, _$_CallModel>
    implements _$$_CallModelCopyWith<$Res> {
  __$$_CallModelCopyWithImpl(
      _$_CallModel _value, $Res Function(_$_CallModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? callId = freezed,
    Object? channelId = freezed,
    Object? callerId = freezed,
    Object? messageId = freezed,
    Object? caller = freezed,
    Object? receiverId = freezed,
    Object? receiver = freezed,
    Object? callStatus = freezed,
    Object? callType = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? createAt = freezed,
    Object? updateAt = freezed,
  }) {
    return _then(_$_CallModel(
      callId: freezed == callId
          ? _value.callId
          : callId // ignore: cast_nullable_to_non_nullable
              as String?,
      channelId: freezed == channelId
          ? _value.channelId
          : channelId // ignore: cast_nullable_to_non_nullable
              as String?,
      callerId: freezed == callerId
          ? _value.callerId
          : callerId // ignore: cast_nullable_to_non_nullable
              as String?,
      messageId: freezed == messageId
          ? _value.messageId
          : messageId // ignore: cast_nullable_to_non_nullable
              as String?,
      caller: freezed == caller
          ? _value.caller
          : caller // ignore: cast_nullable_to_non_nullable
              as BasicUserModel?,
      receiverId: freezed == receiverId
          ? _value.receiverId
          : receiverId // ignore: cast_nullable_to_non_nullable
              as String?,
      receiver: freezed == receiver
          ? _value.receiver
          : receiver // ignore: cast_nullable_to_non_nullable
              as BasicUserModel?,
      callStatus: freezed == callStatus
          ? _value.callStatus
          : callStatus // ignore: cast_nullable_to_non_nullable
              as CallStatusType?,
      callType: freezed == callType
          ? _value.callType
          : callType // ignore: cast_nullable_to_non_nullable
              as CallType?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createAt: freezed == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updateAt: freezed == updateAt
          ? _value.updateAt
          : updateAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class _$_CallModel extends _CallModel {
  const _$_CallModel(
      {this.callId,
      this.channelId,
      this.callerId,
      this.messageId,
      this.caller,
      this.receiverId,
      this.receiver,
      this.callStatus,
      this.callType,
      this.startTime,
      this.endTime,
      this.createAt,
      this.updateAt})
      : super._();

  factory _$_CallModel.fromJson(Map<String, dynamic> json) =>
      _$$_CallModelFromJson(json);

  @override
  final String? callId;
  @override
  final String? channelId;
  @override
  final String? callerId;
  @override
  final String? messageId;
  @override
  final BasicUserModel? caller;
  @override
  final String? receiverId;
  @override
  final BasicUserModel? receiver;
  @override
  final CallStatusType? callStatus;
  @override
  final CallType? callType;
  @override
  final DateTime? startTime;
  @override
  final DateTime? endTime;
  @override
  final DateTime? createAt;
  @override
  final DateTime? updateAt;

  @override
  String toString() {
    return 'CallModel(callId: $callId, channelId: $channelId, callerId: $callerId, messageId: $messageId, caller: $caller, receiverId: $receiverId, receiver: $receiver, callStatus: $callStatus, callType: $callType, startTime: $startTime, endTime: $endTime, createAt: $createAt, updateAt: $updateAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CallModel &&
            (identical(other.callId, callId) || other.callId == callId) &&
            (identical(other.channelId, channelId) ||
                other.channelId == channelId) &&
            (identical(other.callerId, callerId) ||
                other.callerId == callerId) &&
            (identical(other.messageId, messageId) ||
                other.messageId == messageId) &&
            (identical(other.caller, caller) || other.caller == caller) &&
            (identical(other.receiverId, receiverId) ||
                other.receiverId == receiverId) &&
            (identical(other.receiver, receiver) ||
                other.receiver == receiver) &&
            (identical(other.callStatus, callStatus) ||
                other.callStatus == callStatus) &&
            (identical(other.callType, callType) ||
                other.callType == callType) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.updateAt, updateAt) ||
                other.updateAt == updateAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      callId,
      channelId,
      callerId,
      messageId,
      caller,
      receiverId,
      receiver,
      callStatus,
      callType,
      startTime,
      endTime,
      createAt,
      updateAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CallModelCopyWith<_$_CallModel> get copyWith =>
      __$$_CallModelCopyWithImpl<_$_CallModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CallModelToJson(
      this,
    );
  }
}

abstract class _CallModel extends CallModel {
  const factory _CallModel(
      {final String? callId,
      final String? channelId,
      final String? callerId,
      final String? messageId,
      final BasicUserModel? caller,
      final String? receiverId,
      final BasicUserModel? receiver,
      final CallStatusType? callStatus,
      final CallType? callType,
      final DateTime? startTime,
      final DateTime? endTime,
      final DateTime? createAt,
      final DateTime? updateAt}) = _$_CallModel;
  const _CallModel._() : super._();

  factory _CallModel.fromJson(Map<String, dynamic> json) =
      _$_CallModel.fromJson;

  @override
  String? get callId;
  @override
  String? get channelId;
  @override
  String? get callerId;
  @override
  String? get messageId;
  @override
  BasicUserModel? get caller;
  @override
  String? get receiverId;
  @override
  BasicUserModel? get receiver;
  @override
  CallStatusType? get callStatus;
  @override
  CallType? get callType;
  @override
  DateTime? get startTime;
  @override
  DateTime? get endTime;
  @override
  DateTime? get createAt;
  @override
  DateTime? get updateAt;
  @override
  @JsonKey(ignore: true)
  _$$_CallModelCopyWith<_$_CallModel> get copyWith =>
      throw _privateConstructorUsedError;
}
