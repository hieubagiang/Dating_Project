import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:dating_app/app/di/di_setup.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:injectable/injectable.dart';

import '../../data/models/file_download/file_download.dart';
import 'file_helper.dart';

@injectable
class DownloadManager {
  factory DownloadManager() {
    return _instance;
  }

  DownloadManager._privateConstructor() {
    dispose();
    _port = ReceivePort();
    _listenerDownload();
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Timer? _debounce;
  static final DownloadManager _instance =
      DownloadManager._privateConstructor();

  late String _localPath;
  static String stringPort = 'downloader_send_port';
  late ReceivePort _port;

  void _listenerDownload() {
    IsolateNameServer.registerPortWithName(_port.sendPort, stringPort);
    _port.listen((dynamic data) async {
      final String id = data[0] as String;
      final DownloadTaskStatus status = data[1] as DownloadTaskStatus;
      final int progress = data[2] as int;
      final res = await _loadTask(id);
      if (res == null) return;
      getIt.get<EventBus>().fire(
            FileDownload(
              fileName: res.filename,
              taskId: res.taskId,
              urlDownload: res.url,
              progress: progress,
              urlLocal: res.savedDir,
              status: status.value,
            ),
          );
    });
  }

  Future<DownloadTask?> _loadTask(String id) async {
    final String query = 'SELECT * FROM task WHERE task_id="$id"';
    final tasks = await FlutterDownloader.loadTasksWithRawQuery(query: query);
    if (tasks != null) {
      return tasks.first;
    }
    return null;
  }

  bool isNumber(String s) {
    if (s.isEmpty) return false;
    final n = num.tryParse(s);
    return n != null;
  }

  /// This function takes a file name as input and adds a suffix to make it unique
  ///
  /// If a file with the same name already exists in the directory, this function
  /// generates a new file name by adding a numeric suffix to the original file name.
  /// The suffix starts at 1 and is incremented until a unique file name is found.
  /// The function then returns the new unique file name.
  ///     FooBar.xml
  ///     FooBar(1).xml
  ///     FooBar(2).xml
  ///     ...
  ///     FooBar(N).xml

  String createFileName(String fileName) {
    final fileNameWithoutExtension = fileName.split('.').first;
    final fileExtension = fileName.split('.').last;
    var index = 1;
    var uniqueFileName = '$fileNameWithoutExtension.$fileExtension';
    while (File('$_localPath/$uniqueFileName').existsSync()) {
      index++;
      uniqueFileName = '$fileNameWithoutExtension($index).$fileExtension';
    }

    return uniqueFileName;
  }

  Future<String> download(String url, String fileName, {String? ext}) async {
    await _findLocalPath();
    ext ??= fileName.split('.').last;
    String _fileName = fileName;
    _fileName = createFileName(_fileName);

    await FlutterDownloader.enqueue(
      url: url,
      fileName: _fileName,
      savedDir: _localPath,
      saveInPublicStorage: true,
      showNotification: false,
    );

    return '$_localPath/$_fileName';
  }

  Future<void> cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
  }

  Future _findLocalPath() async {
    _localPath = await fileLocalPath();
    return true;
  }

  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    final SendPort? send = IsolateNameServer.lookupPortByName(stringPort);
    send?.send([id, status, progress]);
  }

  void dispose() {
    _debounce?.cancel();
    IsolateNameServer.removePortNameMapping(stringPort);
  }
}
