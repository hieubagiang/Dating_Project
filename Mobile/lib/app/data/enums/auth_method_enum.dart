import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AuthMethodEnum {
  static AuthMethod? getType(int? id) {
    if (id == null) {
      return null;
    }
    return AuthMethod.values.where((value) => value.id == id).first;
  }
}

enum AuthMethod { email, phone, google, facebook }

extension AuthMethodEnumExtension on AuthMethod {
  int get id {
    switch (this) {
      case AuthMethod.email:
        return 1;
      case AuthMethod.phone:
        return 2;
      case AuthMethod.google:
        return 3;
      case AuthMethod.facebook:
        return 4;
    }
  }

  String get label {
    switch (this) {
      case AuthMethod.email:
        return 'signInWithEmailLabel'.tr;
      case AuthMethod.phone:
        return 'signInWithPhoneLabel'.tr;
      case AuthMethod.google:
        return 'signInWithGoogleLabel'.tr;
      case AuthMethod.facebook:
        return 'signInWithFacebookLabel'.tr;
    }
  }
}
