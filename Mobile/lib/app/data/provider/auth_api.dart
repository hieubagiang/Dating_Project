import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/base/api_response.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../common/utils/firebase_storage_utils.dart';
import '../models/user_model/user_model.dart';
import 'api_provider.dart';

class AuthApi {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final _facebookAuth = FacebookAuth.i;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final api = Get.put(Api());

  AuthApi({FirebaseAuth? auth, FirebaseFirestore? fireStore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = fireStore ?? FirebaseFirestore.instance;

  //Sign in
  Future<UserCredential> signInWithEmail(
      {required String email, required String password}) async {
    return await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  //First time user registration
  Future<bool> isExistUserData(String userId) async {
    bool exist = false;
    await _firestore
        .collection(FirebaseStorageConstants.usersCollection)
        .doc(userId)
        .get()
        .then((user) {
      try {
        exist = user.exists;
        if (user.exists) {
          UserModel.fromSnapShot(user);
          return true;
        }
        return false;
      } catch (e) {
        return false;
      }
    });
    return exist;
  }

  //Sign up
  Future<UserCredential> signUpWithEmail(
      {required String email, required String password}) async {
    print(_auth);
    return await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  //Sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }

  //Get currently signed-in users
  Future<bool> isSignedIn() async {
    final currentUser = _auth.currentUser;
    return currentUser != null;
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Map<String, dynamic>? userData;
    UserCredential? userCredential;

    try {
      final result = await _facebookAuth.login();

      switch (result.status) {
        case LoginStatus.success:
          // Create a credential from the access token
          final OAuthCredential credential =
              FacebookAuthProvider.credential(result.accessToken!.token);
          userCredential =
              await FirebaseAuth.instance.signInWithCredential(credential);
          // userData = await _facebookAuth.getUserData();
          break;
        case LoginStatus.cancelled:
          break;
        case LoginStatus.failed:
          break;
        case LoginStatus.operationInProgress:
          break;
      }
    } catch (e) {
      print(e);
    }
    return userCredential;
  }

  void signOutWithFacebook() async {
    await _facebookAuth.logOut();
  }

  Future<UserCredential?> signInWithoutSignIn() async {
    return await _auth.signInAnonymously();
  }

  Future<UserCredential?> signInWithGoogle() async {
    UserCredential? userCredential;
    GoogleSignInAccount? googleSignInAccount;
    try {
      googleSignInAccount = await googleSignIn.signIn();
    } on Exception catch (e) {
      FunctionUtils.logWhenDebug(this, e.toString());
    }

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      try {
        userCredential = await _auth.signInWithCredential(credential);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          FunctionUtils.logWhenDebug(this, e.code);
        } else if (e.code == 'invalid-credential') {
          FunctionUtils.logWhenDebug(this, e.code);
        }
      } catch (e) {
        FunctionUtils.logWhenDebug(this, '$e');
      }
    }

    return userCredential;
  }

//Getting userId.
  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> sendEmailVerification() async {
    await _auth.currentUser?.sendEmailVerification();
  }

  Future<void> sendPasswordResetEmail(
      {required String email, ActionCodeSettings? actionCodeSettings}) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<String> getEmailFromUsername({required String username}) async {
    final ApiResponse? response = await api.baseRequest(
        url: '/getEmail',
        params: {'username': username},
        method: Method.post) as ApiResponse;
    if (response?.data == null) {
      throw Exception("Null data on signInWithUsername");
    }
    Map responseMap = response?.data as Map;
    return responseMap["email"];
  }

  Future<UserCredential> signInWithUsername(
      {required String username, required String password}) async {
    final email = await getEmailFromUsername(username: username);
    return await signInWithEmail(email: email, password: password);
  }
}
