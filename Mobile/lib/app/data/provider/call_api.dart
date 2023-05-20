import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';
import 'package:dating_app/app/data/models/call/call_model.dart';

class CallApi {
  final FirebaseFirestore _firestore;

  CallApi({FirebaseFirestore? fireStore})
      : _firestore = fireStore ?? FirebaseFirestore.instance;

  Future<void> setCallStatus({required CallModel callModel}) async {
    await _firestore
        .collection(FirebaseStorageConstants.callCollection)
        .doc(callModel.callId)
        .update(callModel.copyWith(updateAt: DateTime.now()).toJson()
          ..removeNulls());
  }

  Future<void> ringPhone({required CallModel callModel}) async {
    await _firestore
        .collection(FirebaseStorageConstants.callCollection)
        .doc(callModel.callId)
        .set(callModel.copyWith(createAt: DateTime.now()).toJson());
  }

  Future<CallModel?> getCallInfo({required String callId}) async {
    try {
      final res = await _firestore
          .collection(FirebaseStorageConstants.callCollection)
          .doc(callId)
          .get();
      return CallModel.fromJson(res.data()!);
    } on Exception catch (e) {
      print(e);
      return null;
    }
  }
}
