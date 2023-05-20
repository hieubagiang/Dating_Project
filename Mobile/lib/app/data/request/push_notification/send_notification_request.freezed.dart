// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'send_notification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Data _$DataFromJson(Map<String, dynamic> json) {
  return _Data.fromJson(json);
}

/// @nodoc
mixin _$Data {
  @JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
  String? get clickAction => throw _privateConstructorUsedError;
  @JsonKey(defaultValue: true)
  bool? get alert => throw _privateConstructorUsedError;
  @JsonKey(name: "content_available", defaultValue: true)
  bool? get contentAvailable => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DataCopyWith<Data> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataCopyWith<$Res> {
  factory $DataCopyWith(Data value, $Res Function(Data) then) =
      _$DataCopyWithImpl<$Res, Data>;
  @useResult
  $Res call(
      {@JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
          String? clickAction,
      @JsonKey(defaultValue: true)
          bool? alert,
      @JsonKey(name: "content_available", defaultValue: true)
          bool? contentAvailable});
}

/// @nodoc
class _$DataCopyWithImpl<$Res, $Val extends Data>
    implements $DataCopyWith<$Res> {
  _$DataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickAction = freezed,
    Object? alert = freezed,
    Object? contentAvailable = freezed,
  }) {
    return _then(_value.copyWith(
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
      alert: freezed == alert
          ? _value.alert
          : alert // ignore: cast_nullable_to_non_nullable
              as bool?,
      contentAvailable: freezed == contentAvailable
          ? _value.contentAvailable
          : contentAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DataCopyWith<$Res> implements $DataCopyWith<$Res> {
  factory _$$_DataCopyWith(_$_Data value, $Res Function(_$_Data) then) =
      __$$_DataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
          String? clickAction,
      @JsonKey(defaultValue: true)
          bool? alert,
      @JsonKey(name: "content_available", defaultValue: true)
          bool? contentAvailable});
}

/// @nodoc
class __$$_DataCopyWithImpl<$Res> extends _$DataCopyWithImpl<$Res, _$_Data>
    implements _$$_DataCopyWith<$Res> {
  __$$_DataCopyWithImpl(_$_Data _value, $Res Function(_$_Data) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clickAction = freezed,
    Object? alert = freezed,
    Object? contentAvailable = freezed,
  }) {
    return _then(_$_Data(
      clickAction: freezed == clickAction
          ? _value.clickAction
          : clickAction // ignore: cast_nullable_to_non_nullable
              as String?,
      alert: freezed == alert
          ? _value.alert
          : alert // ignore: cast_nullable_to_non_nullable
              as bool?,
      contentAvailable: freezed == contentAvailable
          ? _value.contentAvailable
          : contentAvailable // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Data implements _Data {
  const _$_Data(
      {@JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
          this.clickAction,
      @JsonKey(defaultValue: true)
          this.alert,
      @JsonKey(name: "content_available", defaultValue: true)
          this.contentAvailable});

  factory _$_Data.fromJson(Map<String, dynamic> json) => _$$_DataFromJson(json);

  @override
  @JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
  final String? clickAction;
  @override
  @JsonKey(defaultValue: true)
  final bool? alert;
  @override
  @JsonKey(name: "content_available", defaultValue: true)
  final bool? contentAvailable;

  @override
  String toString() {
    return 'Data(clickAction: $clickAction, alert: $alert, contentAvailable: $contentAvailable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Data &&
            (identical(other.clickAction, clickAction) ||
                other.clickAction == clickAction) &&
            (identical(other.alert, alert) || other.alert == alert) &&
            (identical(other.contentAvailable, contentAvailable) ||
                other.contentAvailable == contentAvailable));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, clickAction, alert, contentAvailable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DataCopyWith<_$_Data> get copyWith =>
      __$$_DataCopyWithImpl<_$_Data>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DataToJson(
      this,
    );
  }
}

abstract class _Data implements Data {
  const factory _Data(
      {@JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
          final String? clickAction,
      @JsonKey(defaultValue: true)
          final bool? alert,
      @JsonKey(name: "content_available", defaultValue: true)
          final bool? contentAvailable}) = _$_Data;

  factory _Data.fromJson(Map<String, dynamic> json) = _$_Data.fromJson;

  @override
  @JsonKey(name: "click_action", defaultValue: "FLUTTER_NOTIFICATION_CLICK")
  String? get clickAction;
  @override
  @JsonKey(defaultValue: true)
  bool? get alert;
  @override
  @JsonKey(name: "content_available", defaultValue: true)
  bool? get contentAvailable;
  @override
  @JsonKey(ignore: true)
  _$$_DataCopyWith<_$_Data> get copyWith => throw _privateConstructorUsedError;
}

SendNotificationRequest _$SendNotificationRequestFromJson(
    Map<String, dynamic> json) {
  return _SendNotificationRequest.fromJson(json);
}

/// @nodoc
mixin _$SendNotificationRequest {
  @JsonKey(name: "user_ids")
  List<String>? get userIds => throw _privateConstructorUsedError;
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;
  NotificationRequest? get notification => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SendNotificationRequestCopyWith<SendNotificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SendNotificationRequestCopyWith<$Res> {
  factory $SendNotificationRequestCopyWith(SendNotificationRequest value,
          $Res Function(SendNotificationRequest) then) =
      _$SendNotificationRequestCopyWithImpl<$Res, SendNotificationRequest>;
  @useResult
  $Res call(
      {@JsonKey(name: "user_ids") List<String>? userIds,
      Map<String, dynamic>? data,
      NotificationRequest? notification});
}

/// @nodoc
class _$SendNotificationRequestCopyWithImpl<$Res,
        $Val extends SendNotificationRequest>
    implements $SendNotificationRequestCopyWith<$Res> {
  _$SendNotificationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userIds = freezed,
    Object? data = freezed,
    Object? notification = freezed,
  }) {
    return _then(_value.copyWith(
      userIds: freezed == userIds
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      notification: freezed == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as NotificationRequest?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SendNotificationRequestCopyWith<$Res>
    implements $SendNotificationRequestCopyWith<$Res> {
  factory _$$_SendNotificationRequestCopyWith(_$_SendNotificationRequest value,
          $Res Function(_$_SendNotificationRequest) then) =
      __$$_SendNotificationRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: "user_ids") List<String>? userIds,
      Map<String, dynamic>? data,
      NotificationRequest? notification});
}

/// @nodoc
class __$$_SendNotificationRequestCopyWithImpl<$Res>
    extends _$SendNotificationRequestCopyWithImpl<$Res,
        _$_SendNotificationRequest>
    implements _$$_SendNotificationRequestCopyWith<$Res> {
  __$$_SendNotificationRequestCopyWithImpl(_$_SendNotificationRequest _value,
      $Res Function(_$_SendNotificationRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userIds = freezed,
    Object? data = freezed,
    Object? notification = freezed,
  }) {
    return _then(_$_SendNotificationRequest(
      userIds: freezed == userIds
          ? _value._userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      notification: freezed == notification
          ? _value.notification
          : notification // ignore: cast_nullable_to_non_nullable
              as NotificationRequest?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SendNotificationRequest implements _SendNotificationRequest {
  const _$_SendNotificationRequest(
      {@JsonKey(name: "user_ids") final List<String>? userIds,
      final Map<String, dynamic>? data,
      this.notification})
      : _userIds = userIds,
        _data = data;

  factory _$_SendNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$$_SendNotificationRequestFromJson(json);

  final List<String>? _userIds;
  @override
  @JsonKey(name: "user_ids")
  List<String>? get userIds {
    final value = _userIds;
    if (value == null) return null;
    if (_userIds is EqualUnmodifiableListView) return _userIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final NotificationRequest? notification;

  @override
  String toString() {
    return 'SendNotificationRequest(userIds: $userIds, data: $data, notification: $notification)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SendNotificationRequest &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            const DeepCollectionEquality().equals(other._data, _data) &&
            (identical(other.notification, notification) ||
                other.notification == notification));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_userIds),
      const DeepCollectionEquality().hash(_data),
      notification);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SendNotificationRequestCopyWith<_$_SendNotificationRequest>
      get copyWith =>
          __$$_SendNotificationRequestCopyWithImpl<_$_SendNotificationRequest>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SendNotificationRequestToJson(
      this,
    );
  }
}

abstract class _SendNotificationRequest implements SendNotificationRequest {
  const factory _SendNotificationRequest(
      {@JsonKey(name: "user_ids") final List<String>? userIds,
      final Map<String, dynamic>? data,
      final NotificationRequest? notification}) = _$_SendNotificationRequest;

  factory _SendNotificationRequest.fromJson(Map<String, dynamic> json) =
      _$_SendNotificationRequest.fromJson;

  @override
  @JsonKey(name: "user_ids")
  List<String>? get userIds;
  @override
  Map<String, dynamic>? get data;
  @override
  NotificationRequest? get notification;
  @override
  @JsonKey(ignore: true)
  _$$_SendNotificationRequestCopyWith<_$_SendNotificationRequest>
      get copyWith => throw _privateConstructorUsedError;
}
