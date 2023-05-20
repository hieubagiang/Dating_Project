import 'package:dating_app/app/data/models/args/verify_phone_number_screen_args.dart';

import '../../../../../../common/base/base_controller.dart';

class VerifyPhoneNumberController extends BaseController {
  late RxString phoneNumber;
  RxBool isEditing = false.obs;
  RxString? enteredOTP = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    phoneNumber = (Get.arguments as VerifyPhoneNumberArgs).phoneNumber.obs;
  }

  verifyOTP({String? otp}) {}
}
