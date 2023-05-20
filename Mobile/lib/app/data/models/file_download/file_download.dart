import 'package:freezed_annotation/freezed_annotation.dart';

part 'file_download.freezed.dart';
part 'file_download.g.dart';

@freezed
class FileDownload with _$FileDownload {
  const factory FileDownload({
    String? fileName,
    String? ext,
    String? urlLocal,
    String? urlDownload,
    int? progress,
    String? taskId,
    int? status,
  }) = _FileDownload;

  factory FileDownload.fromJson(Map<String, dynamic> json) =>
      _$FileDownloadFromJson(json);
}
