// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_download.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FileDownload _$$_FileDownloadFromJson(Map<String, dynamic> json) =>
    _$_FileDownload(
      fileName: json['fileName'] as String?,
      ext: json['ext'] as String?,
      urlLocal: json['urlLocal'] as String?,
      urlDownload: json['urlDownload'] as String?,
      progress: json['progress'] as int?,
      taskId: json['taskId'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$$_FileDownloadToJson(_$_FileDownload instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'ext': instance.ext,
      'urlLocal': instance.urlLocal,
      'urlDownload': instance.urlDownload,
      'progress': instance.progress,
      'taskId': instance.taskId,
      'status': instance.status,
    };
