import 'package:get/get_utils/src/extensions/internacionalization.dart';

class ErrorCodeEnum {
  static ErrorCode? getErrorCode(String? code) {
    if (code == null || code.isEmpty) {
      return null;
    }
    ErrorCode? result;
    result =
        ErrorCode.values.firstWhereOrNull((element) => element.code == code);
    return result;
  }
}

enum ErrorCode {
  userNotFound,
  userDisabled,
  weakPassword,
  emailAlreadyInUse,
  wrongPassword,
  tooManyRequests,
}

extension ErrorCodeExtension on ErrorCode {
  String get code {
    switch (this) {
      case ErrorCode.userNotFound:
        return 'user-not-found';
      case ErrorCode.wrongPassword:
        return 'wrong-password';
      case ErrorCode.userDisabled:
        return 'user-disabled';
      case ErrorCode.weakPassword:
        return 'weak-password';
      case ErrorCode.emailAlreadyInUse:
        return 'email-already-in-use';
      case ErrorCode.tooManyRequests:
        return 'too-many-requests';
      default:
        return 'someThingWhenWrong';
    }
  }

  String get message {
    switch (this) {
      case ErrorCode.userNotFound:
        return 'useNotFoundError'.tr;
      case ErrorCode.wrongPassword:
        return 'wrongPassword'.tr;
      case ErrorCode.userDisabled:
        return 'userDisabled'.tr;
      case ErrorCode.weakPassword:
        return 'weakPassword'.tr;
      case ErrorCode.emailAlreadyInUse:
        return 'emailAlreadyInUse'.tr;
      case ErrorCode.tooManyRequests:
        return 'tooManyRequests'.tr;
      default:
        return 'someThingWhenWrong'.tr;
    }
  }

  bool get showErrorMessage {
    switch (this) {
      case ErrorCode.userNotFound:
        return true;

      default:
        return true;
    }
  }
}
