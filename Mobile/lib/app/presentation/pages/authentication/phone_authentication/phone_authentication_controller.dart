import 'package:dating_app/app/data/models/args/verify_phone_number_screen_args.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_in/mixins/phone_authentication_mixin.dart';

import '../../../../common/base/base_controller.dart';
import '../../../../routes/app_pages.dart';
import '../sign_in/mixins/validate_mixin.dart';

class PhoneAuthenticationController extends BaseController
    with ValidateFormMixin, PhoneAuthenticationMixin {
  @override
  void signInWithPhone() {
    if (validateForm) {
      Get.toNamed(RouteList.verifyPhoneNumberScreen,
          arguments: VerifyPhoneNumberArgs('+84' + phoneTextController.text));
    }
  }
}
