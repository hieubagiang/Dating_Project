import 'dart:io';

import 'package:dating_app/app/di/di_setup.dart';
import 'package:external_path/external_path.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import 'download_manage.dart';
import 'log_utils.dart';

Future<List<PlatformFile>?> chooseFiles({
  List<String>? extensions,
}) async {
  final result = await FilePicker.platform.pickFiles(
    allowMultiple: true,
    allowedExtensions: extensions,
    type: extensions != null ? FileType.custom : FileType.any,
  );

  return result?.files;
}

Future<void> openUrl(String path) async {
  final Uri url = Uri.parse(path);
  await launchUrl(url);
}

Future<List<File>?> chooseImages() async {
  final ImagePicker picker = ImagePicker();
  final images = await picker.pickMultiImage();

  return images?.map((e) => File(e.path)).toList();
}

Future<File?> chooseImage() async {
  final ImagePicker picker = ImagePicker();
  final image =
      await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
  if (kDebugMode) {
    print(await image?.length());
  }
  return image != null ? File(image.path) : null;
}

Future<File?> chooseImageWithFilePicker() async {
  final FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.image,
  );
  return result?.files.single.path != null
      ? File(result!.files.single.path!)
      : null;
}

Future<File?> downloadFile(
  String fileUrl, {
  String? fileName,
  String? cookie,
  void Function(int, int?)? onByteReceived,
}) async {
  // File? file;
  final per = await Permission.storage.request();
  if (per.isPermanentlyDenied) {
    openAppSettings();
    return null;
  }
  try {
    final fName = fileName ?? fileUrl.split('/').last;
    final path = await getIt.get<DownloadManager>().download(fileUrl, fName);
    return File(path);
  } catch (e) {
    // ignore: avoid_print
    logger.logD('-- Exception: ${e.toString()}');
    return null;
  }
}

Future<String> fileLocalPath() async {
  if (Platform.isMacOS) {
    return '';
  }
  final per = await Permission.storage.request();
  if (per.isPermanentlyDenied) {
    openAppSettings();
    return '';
  }
  Directory? tempDir;
  if (Platform.isAndroid) {
    final path = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOADS,
    );
    tempDir = Directory(path);
  } else {
    tempDir = await getApplicationDocumentsDirectory()
      ..absolute.path;
  }
  final localPath = tempDir.path;
  final savedDir = Directory(localPath);
  final bool hasExisted = await savedDir.exists();
  if (!hasExisted) {
    savedDir.create(recursive: true);
  }
  return localPath;
}
