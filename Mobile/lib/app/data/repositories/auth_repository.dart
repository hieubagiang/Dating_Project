import 'package:dating_app/app/data/provider/auth_api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthRepository {
  final api = Get.find<AuthApi>();

  Future<UserCredential> signInWithEmail(
      {required String email, required String password}) async {
    return await api.signInWithEmail(email: email, password: password);
  }

  Future<UserCredential> signUpWithEmail(
      {required String email, required String password}) async {
    return await api.signUpWithEmail(email: email, password: password);
  }

  Future<UserCredential> signInWithUsername(
      {required String username, required String password}) async {
    return await api.signInWithUsername(username: username, password: password);
  }

  Future<void> sendEmailVerification() async {
    return await api.sendEmailVerification();
  }

  Future<String> getEmailFromUsername({required String username}) async {
    return await api.getEmailFromUsername(username: username);
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    return await api.sendPasswordResetEmail(email: email);
  }

  Future<bool> isExistUserData(String userId) async {
    return api.isExistUserData(userId);
  }

  //Sign out
  Future<void> signOut() async {
    return await api.signOut();
  }

  //Get currently signed-in users
  Future<bool> isSignedIn() async {
    return await api.isSignedIn();
  }

  Future<UserCredential?> signInWithGoogle() async {
    return await api.signInWithGoogle();
  }

  Future<UserCredential?> signInWithoutSignIn() async {
    return await api.signInWithoutSignIn();
  }

  Future<UserCredential?> signInWithFacebook() async {
    return await api.signInWithFacebook();
  }

  Future<UserCredential> signInAnonymously() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    UserCredential userCredential = await auth.signInAnonymously();
    return userCredential;
  }

  String? get currentUserId => api.currentUserId;
}
