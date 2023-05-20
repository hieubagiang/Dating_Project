import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/payment_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/presentation/pages/premium/premium_screen.dart';

import '../../../data/models/subscription_package_model/subscription_package_model.dart';

class PremiumController extends BaseController {
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  RxInt indexChoose = 1.obs;
  final paymentRepository = Get.find<PaymentRepository>();
  final userRepo = Get.find<UserRepository>();
  RxList<SubscriptionPackageModel> subscriptionPackages = RxList([]);
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    subscriptionPackages.value = await userRepo.getSubscriptionPackages();
  }

  showDialogPremium() {
    Get.dialog(
      PremiumDialog(
        subscriptionPackages: subscriptionPackages,
      ),
    );
  }
}
