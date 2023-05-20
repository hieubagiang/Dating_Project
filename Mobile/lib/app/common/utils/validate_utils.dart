import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class Validate {
  static final phoneValidator = MultiValidator([
    RequiredValidator(errorText: "phoneRequiredText".tr),
    MinLengthValidator(9, errorText: 'phoneLengthRequiredText'.tr),
  ]);
  static final usernameValidator = MultiValidator([
    RequiredValidator(errorText: "fieldRequiredText".tr),
  ]);
  static final emailValidator = MultiValidator([
    RequiredValidator(errorText: "fieldRequiredText".tr),
    EmailValidator(errorText: "emailFormatErrorText".tr),
  ]);

  static final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'passwordRequiredText'.tr),
    MinLengthValidator(6,
        errorText: 'passwordLengthRequiredText'.trParams({'minLength': '6'})),
  ]);
  static final nameValidator = MultiValidator([
    RequiredValidator(errorText: "fieldRequiredText".tr),
  ]);
}
