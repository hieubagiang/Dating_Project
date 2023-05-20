import 'package:firebase_auth/firebase_auth.dart';

class Test extends FirebaseAuthException {
  Test(
    String code,
  ) : super(code: code);
}
