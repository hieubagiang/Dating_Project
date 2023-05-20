import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/firebase_storage_utils.dart';
import 'package:dating_app/app/data/models/payment/payment_model.dart';
import 'package:dating_app/app/data/models/subscription_package_model/subscription_package_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../common/utils/index.dart';

class PaymentFirebaseApi {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  PaymentFirebaseApi({FirebaseAuth? auth, FirebaseFirestore? fireStore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = fireStore ?? FirebaseFirestore.instance;

  Stream<PaymentModel?> listenPayment({String? paymentId}) async* {
    try {
      yield* _firestore
          .collection(FirebaseStorageConstants.paymentHistoriesCollection)
          .doc(paymentId)
          .snapshots()
          .map((snapshot) {
        return PaymentModel.fromSnapShot(snapshot);
      });
    } catch (e) {
      FunctionUtils.logWhenDebug(this, e.toString());
    }
    // yield null;
  }

  Future<List<SubscriptionPackageModel>> getSubscriptionPackages() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('subscription_packages')
        .get();

    return SubscriptionPackageModel.fromQuerySnapshot(snapshot);
  }

  //Getting userId.
  String? get userId => _auth.currentUser?.uid;
}
