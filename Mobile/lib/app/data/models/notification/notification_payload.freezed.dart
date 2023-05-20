// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_payload.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NotificationPayload _$NotificationPayloadFromJson(Map<String, dynamic> json) {
  return _NotificationPayload.fromJson(json);
}

/// @nodoc
mixin _$NotificationPayload {
  NotificationType? get notificationType => throw _privateConstructorUsedError;
  CallModel? get callModel => throw _privateConstructorUsedError;
  PaymentModel? get paymentModel => throw _privateConstructorUsedError;
  ChannelModel? get channelModel => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK')
  String? get clickAction => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotificationPayloadCopyWith<NotificationPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NotificationPayloadCopyWith<$Res> {
  factory $NotificationPayloadCopyWith(
          NotificationPayload value, $Res Function(NotificationPayload) then) =
      _$NotificationPayloadCopyWithImpl<$Res, NotificationPayload>;
  @useResult
  $Res call(
      {NotificationType? notificationType,
      CallModel? callModel,
      PaymentModel? paymentModel,
      ChannelModel? channelModel,
      @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK')
          String? clickAction});

  $CallModelCopyWith<$Res>? get callModel;
  $PaymentModelCopyWith<$Res>? get paymentModel;
}

/// @nodoc
class _$NotificationPayloadCopyWithImpl<$Res, $Val extends NotificationPayload>
    implements $NotificationPayloadCopyWith<$Res> {
  _$NotificationPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationType = freezed,
    Object? callModel = freezed,
    Object? paymentModel = freezed,
    Object? channelModel = freezed,
    Object? clickAction = freezed,
  }) {
    return _then(_value.copyWith(
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as NotificationType?,
      callModel: freezed == callModel
          ? _value.callModel
          : callModel // ignore: cast_nullable_to_non_nullable
              as CallModel?,
      paymentModel: freezed == paymentModel
          ? _value.paymentModel
          : paymentModel // ignore: cast_nullable_to_non_nullable
              as PaymentModel?,
      channelModel: freezed == channelModel
          ? _value.channelModel
          : channelModel // ignore: cast_nullable_to_non_nullable
              as ChannelModel?,
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CallModelCopyWith<$Res>? get callModel {
    if (_value.callModel == null) {
      return null;
    }

    return $CallModelCopyWith<$Res>(_value.callModel!, (value) {
      return _then(_value.copyWith(callModel: value) as $Val);
    });
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
abstract class _$$_NotificationPayloadCopyWith<$Res>
    implements $NotificationPayloadCopyWith<$Res> {
  factory _$$_NotificationPayloadCopyWith(_$_NotificationPayload value,
          $Res Function(_$_NotificationPayload) then) =
      __$$_NotificationPayloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {NotificationType? notificationType,
      CallModel? callModel,
      PaymentModel? paymentModel,
      ChannelModel? channelModel,
      @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK')
          String? clickAction});

  @override
  $CallModelCopyWith<$Res>? get callModel;
  @override
  $PaymentModelCopyWith<$Res>? get paymentModel;
}

/// @nodoc
class __$$_NotificationPayloadCopyWithImpl<$Res>
    extends _$NotificationPayloadCopyWithImpl<$Res, _$_NotificationPayload>
    implements _$$_NotificationPayloadCopyWith<$Res> {
  __$$_NotificationPayloadCopyWithImpl(_$_NotificationPayload _value,
      $Res Function(_$_NotificationPayload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? notificationType = freezed,
    Object? callModel = freezed,
    Object? paymentModel = freezed,
    Object? channelModel = freezed,
    Object? clickAction = freezed,
  }) {
    return _then(_$_NotificationPayload(
      notificationType: freezed == notificationType
          ? _value.notificationType
          : notificationType // ignore: cast_nullable_to_non_nullable
              as NotificationType?,
      callModel: freezed == callModel
          ? _value.callModel
          : callModel // ignore: cast_nullable_to_non_nullable
              as CallModel?,
      paymentModel: freezed == paymentModel
          ? _value.paymentModel
          : paymentModel // ignore: cast_nullable_to_non_nullable
              as PaymentModel?,
      channelModel: freezed == channelModel
          ? _value.channelModel
          : channelModel // ignore: cast_nullable_to_non_nullable
              as ChannelModel?,
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_NotificationPayload extends _NotificationPayload {
  const _$_NotificationPayload(
      {this.notificationType,
      this.callModel,
      this.paymentModel,
      this.channelModel,
      @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK') this.clickAction})
      : super._();

  factory _$_NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$$_NotificationPayloadFromJson(json);

  @override
  final NotificationType? notificationType;
  @override
  final CallModel? callModel;
  @override
  final PaymentModel? paymentModel;
  @override
  final ChannelModel? channelModel;
  @override
  @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK')
  final String? clickAction;

  @override
  String toString() {
    return 'NotificationPayload(notificationType: $notificationType, callModel: $callModel, paymentModel: $paymentModel, channelModel: $channelModel, clickAction: $clickAction)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NotificationPayload &&
            (identical(other.notificationType, notificationType) ||
                other.notificationType == notificationType) &&
            (identical(other.callModel, callModel) ||
                other.callModel == callModel) &&
            (identical(other.paymentModel, paymentModel) ||
                other.paymentModel == paymentModel) &&
            (identical(other.channelModel, channelModel) ||
                other.channelModel == channelModel) &&
            (identical(other.clickAction, clickAction) ||
                other.clickAction == clickAction));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, notificationType, callModel,
      paymentModel, channelModel, clickAction);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NotificationPayloadCopyWith<_$_NotificationPayload> get copyWith =>
      __$$_NotificationPayloadCopyWithImpl<_$_NotificationPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NotificationPayloadToJson(
      this,
    );
  }
}

abstract class _NotificationPayload extends NotificationPayload {
  const factory _NotificationPayload(
      {final NotificationType? notificationType,
      final CallModel? callModel,
      final PaymentModel? paymentModel,
      final ChannelModel? channelModel,
      @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK')
          final String? clickAction}) = _$_NotificationPayload;
  const _NotificationPayload._() : super._();

  factory _NotificationPayload.fromJson(Map<String, dynamic> json) =
      _$_NotificationPayload.fromJson;

  @override
  NotificationType? get notificationType;
  @override
  CallModel? get callModel;
  @override
  PaymentModel? get paymentModel;
  @override
  ChannelModel? get channelModel;
  @override
  @JsonKey(defaultValue: 'FLUTTER_NOTIFICATION_CLICK')
  String? get clickAction;
  @override
  @JsonKey(ignore: true)
  _$$_NotificationPayloadCopyWith<_$_NotificationPayload> get copyWith =>
      throw _privateConstructorUsedError;
}
