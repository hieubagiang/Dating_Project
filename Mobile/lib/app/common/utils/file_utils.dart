import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dating_app/app/common/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<Uint8List> compressFile(Uint8List images, int maxWidth) async {
    var result = await FlutterImageCompress.compressWithList(images,
        quality: ConstantsUtils.imageQuality, minWidth: 400);
    return result;
  }

/*  static Future<bool> saveImage(String url) async {
    final xFile = await getXFileFromUrl(url);
    final response = await GallerySaver.saveImage(xFile.path);
    return response!;
  }*/

  static String base64EncodeFormat(Uint8List images) {
    String format = 'data:images/jpeg;base64,';
    String data = base64Encode(images);
    return format + data;
  }

  static Map<String, dynamic> removeNull(Map<String, dynamic> map) {
    map.removeWhere((key, value) => value == null);
    return map;
  }

  static Future<Uint8List> readByteFromUrl(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return bytes;
  }

  static Future<File> writeToFile(Uint8List data, String path) {
    return File(path).writeAsBytes(data);
  }

  static Future<XFile> getXFileFromUrl(String url) async {
    final regexp = RegExp(r'\w+.jpeg');
    final dir = await getApplicationDocumentsDirectory();
    final getFileName = regexp.firstMatch(url)?.group(0);
    String path = '${dir.path}/$getFileName';
    final bytes = await FileUtils.readByteFromUrl(url);
    await FileUtils.writeToFile(bytes, path);
    XFile tmp = XFile(path);
    return tmp;
  }

  static Future<String> getBase64FromXFile(XFile xFile, int maxWidth) async {
    var sourceBytes = await xFile.readAsBytes();
    var largeBytes = await FileUtils.compressFile(sourceBytes, maxWidth);
    // var largeBytes2 = await FileUtils.compressFile2(sourceBytes, maxWidth);
    String base64Large = FileUtils.base64EncodeFormat(largeBytes);
    return base64Large;
  }

  static Future<String> getFilePath(String fileName) async {
    Directory appDocumentsDirectory =
        await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/$fileName'; // 3
    return filePath;
  }

  static Future<double> getFileSizeAsKB(
      {Uint8List? img, String? filepath, int? decimals}) async {
    int bytes;
    if (img != null) {
      bytes = img.lengthInBytes;
    } else {
      var file = File(filepath!);
      bytes = await file.length();
    }
    if (bytes <= 0) return 0;
    // const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return (bytes / pow(1024, i));
    //return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + ' ' + suffixes[i];
  }

  static Future<File?> getImageAndCrop() async {
    final _picker = ImagePicker();
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      print('file path is ${pickedFile.path}');
      final File imageFileFromGallery = File(pickedFile.path);
      File? croppedFile = await cropImageFile(imageFileFromGallery);
      if (croppedFile != null) {
        return croppedFile;
      }
    } else {
      print('file path is null');
    }
    return null;
  }

  static Future<File?> cropImageFile(File image) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
        /*WebUiSettings(
          context: context,
        ),*/
      ],
    );
    if (croppedFile == null) return null;

    return File(croppedFile.path);
  }

  static Future<List<File>?> chooseImages() async {
    final ImagePicker _picker = ImagePicker();
    final images = await _picker.pickMultiImage(imageQuality: 80);

    return images?.map((e) => File(e.path)).toList();
  }

  static Future<bool> saveImage(String url, {String? fileName}) async {
    final xFile = await getXFileFromUrl(url);
    final response = await GallerySaver.saveImage(xFile.path);
    return response!;
  }
}
