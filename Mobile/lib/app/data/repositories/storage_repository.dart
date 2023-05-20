import 'dart:io';

import 'package:dating_app/app/data/models/user_model/photo_model/photo_model.dart';
import 'package:dating_app/app/data/provider/storage_api.dart';
import 'package:get/get.dart';

import '../models/chat/attachment_model.dart';

class StorageRepository {
  final StorageApi api = Get.find<StorageApi>();

  String? get userId => api.userId;

  Future<Attachment> uploadFile(File file, {String? fileName}) async {
    return api.uploadFile(file, fileName: fileName);
  }

  Future<String> getDownloadURL(String imageName) async {
    return api.getDownloadURL(imageName);
  }

  Future<List<PhotoModel>> getUserPhotos() async {
    return api.getUserPhotos(userId!);
  }
}
