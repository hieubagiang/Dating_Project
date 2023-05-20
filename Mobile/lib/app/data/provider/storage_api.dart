import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/attachment_type.dart';
import 'package:dating_app/app/data/models/chat/attachment_model.dart';
import 'package:dating_app/app/data/models/user_model/photo_model/photo_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime/mime.dart';

class StorageApi {
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;
  final ref = 'photos';
  final fullPath =
      'https://firebasestorage.googleapis.com/v0/b/tinder-clone-36718.appspot.com/o/photos/';

  StorageApi({FirebaseAuth? auth, FirebaseStorage? firebaseStorage})
      : _auth = auth ?? FirebaseAuth.instance,
        _storage = firebaseStorage ?? FirebaseStorage.instance;

  //Getting userId.
  String? get userId {
    return _auth.currentUser?.uid;
  }

  Future<Attachment> uploadFile(File file, {String? fileName}) async {
    late String name;
    if (fileName != null) {
      name = '$fileName.${file.path.split('.').last}';
    } else {
      name = file.path.split('/').last;
    }
    TaskSnapshot taskSnapshot =
        await _storage.ref(ref).child(userId!).child(name).putFile(file);
    final url = await taskSnapshot.ref.getDownloadURL();
    Attachment attachmentModel = Attachment(
      url: url,
      type: AttachmentTypeEnum.getTypeFromMime(lookupMimeType(name)!),
      fileName: name,
      fileSize: taskSnapshot.bytesTransferred.toSize,
    );
    return attachmentModel;
  }

  Future<String> getDownloadURL(String imageName) async {
    String downloadURL = await _storage
        .ref(ref)
        .child(userId!)
        .child(imageName)
        .getDownloadURL();
    return downloadURL;
  }

  Future<List<PhotoModel>> getUserPhotos(String userId) async {
    List<String> imageUrlList = [];
    ListResult response = await _storage.ref(ref).child(userId).listAll();
    for (var tmp in response.items) {
      imageUrlList.add(await tmp.getDownloadURL());
    }
    imageUrlList.removeWhere((element) => element.contains('avatar'));

    return imageUrlList
        .mapIndexed((index, e) =>
            PhotoModel(id: index, url: e, createAt: DateTime.now()))
        .toList();
  }
}
