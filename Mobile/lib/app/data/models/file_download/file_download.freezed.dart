// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'file_download.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FileDownload _$FileDownloadFromJson(Map<String, dynamic> json) {
  return _FileDownload.fromJson(json);
}

/// @nodoc
mixin _$FileDownload {
  String? get fileName => throw _privateConstructorUsedError;
  String? get ext => throw _privateConstructorUsedError;
  String? get urlLocal => throw _privateConstructorUsedError;
  String? get urlDownload => throw _privateConstructorUsedError;
  int? get progress => throw _privateConstructorUsedError;
  String? get taskId => throw _privateConstructorUsedError;
  int? get status => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FileDownloadCopyWith<FileDownload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileDownloadCopyWith<$Res> {
  factory $FileDownloadCopyWith(
          FileDownload value, $Res Function(FileDownload) then) =
      _$FileDownloadCopyWithImpl<$Res, FileDownload>;
  @useResult
  $Res call(
      {String? fileName,
      String? ext,
      String? urlLocal,
      String? urlDownload,
      int? progress,
      String? taskId,
      int? status});
}

/// @nodoc
class _$FileDownloadCopyWithImpl<$Res, $Val extends FileDownload>
    implements $FileDownloadCopyWith<$Res> {
  _$FileDownloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = freezed,
    Object? ext = freezed,
    Object? urlLocal = freezed,
    Object? urlDownload = freezed,
    Object? progress = freezed,
    Object? taskId = freezed,
    Object? status = freezed,
  }) {
    return _then(_value.copyWith(
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      ext: freezed == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String?,
      urlLocal: freezed == urlLocal
          ? _value.urlLocal
          : urlLocal // ignore: cast_nullable_to_non_nullable
              as String?,
      urlDownload: freezed == urlDownload
          ? _value.urlDownload
          : urlDownload // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FileDownloadCopyWith<$Res>
    implements $FileDownloadCopyWith<$Res> {
  factory _$$_FileDownloadCopyWith(
          _$_FileDownload value, $Res Function(_$_FileDownload) then) =
      __$$_FileDownloadCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? fileName,
      String? ext,
      String? urlLocal,
      String? urlDownload,
      int? progress,
      String? taskId,
      int? status});
}

/// @nodoc
class __$$_FileDownloadCopyWithImpl<$Res>
    extends _$FileDownloadCopyWithImpl<$Res, _$_FileDownload>
    implements _$$_FileDownloadCopyWith<$Res> {
  __$$_FileDownloadCopyWithImpl(
      _$_FileDownload _value, $Res Function(_$_FileDownload) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fileName = freezed,
    Object? ext = freezed,
    Object? urlLocal = freezed,
    Object? urlDownload = freezed,
    Object? progress = freezed,
    Object? taskId = freezed,
    Object? status = freezed,
  }) {
    return _then(_$_FileDownload(
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      ext: freezed == ext
          ? _value.ext
          : ext // ignore: cast_nullable_to_non_nullable
              as String?,
      urlLocal: freezed == urlLocal
          ? _value.urlLocal
          : urlLocal // ignore: cast_nullable_to_non_nullable
              as String?,
      urlDownload: freezed == urlDownload
          ? _value.urlDownload
          : urlDownload // ignore: cast_nullable_to_non_nullable
              as String?,
      progress: freezed == progress
          ? _value.progress
          : progress // ignore: cast_nullable_to_non_nullable
              as int?,
      taskId: freezed == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FileDownload implements _FileDownload {
  const _$_FileDownload(
      {this.fileName,
      this.ext,
      this.urlLocal,
      this.urlDownload,
      this.progress,
      this.taskId,
      this.status});

  factory _$_FileDownload.fromJson(Map<String, dynamic> json) =>
      _$$_FileDownloadFromJson(json);

  @override
  final String? fileName;
  @override
  final String? ext;
  @override
  final String? urlLocal;
  @override
  final String? urlDownload;
  @override
  final int? progress;
  @override
  final String? taskId;
  @override
  final int? status;

  @override
  String toString() {
    return 'FileDownload(fileName: $fileName, ext: $ext, urlLocal: $urlLocal, urlDownload: $urlDownload, progress: $progress, taskId: $taskId, status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileDownload &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.ext, ext) || other.ext == ext) &&
            (identical(other.urlLocal, urlLocal) ||
                other.urlLocal == urlLocal) &&
            (identical(other.urlDownload, urlDownload) ||
                other.urlDownload == urlDownload) &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.taskId, taskId) || other.taskId == taskId) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fileName, ext, urlLocal,
      urlDownload, progress, taskId, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FileDownloadCopyWith<_$_FileDownload> get copyWith =>
      __$$_FileDownloadCopyWithImpl<_$_FileDownload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FileDownloadToJson(
      this,
    );
  }
}

abstract class _FileDownload implements FileDownload {
  const factory _FileDownload(
      {final String? fileName,
      final String? ext,
      final String? urlLocal,
      final String? urlDownload,
      final int? progress,
      final String? taskId,
      final int? status}) = _$_FileDownload;

  factory _FileDownload.fromJson(Map<String, dynamic> json) =
      _$_FileDownload.fromJson;

  @override
  String? get fileName;
  @override
  String? get ext;
  @override
  String? get urlLocal;
  @override
  String? get urlDownload;
  @override
  int? get progress;
  @override
  String? get taskId;
  @override
  int? get status;
  @override
  @JsonKey(ignore: true)
  _$$_FileDownloadCopyWith<_$_FileDownload> get copyWith =>
      throw _privateConstructorUsedError;
}
