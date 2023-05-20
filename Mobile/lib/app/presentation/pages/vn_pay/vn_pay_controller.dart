import 'package:dating_app/app/common/base/base_controller.dart';
import 'package:dating_app/app/data/models/payment/payment_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/repositories/payment_repository.dart';
import 'package:dating_app/app/data/request/payment/payment_request.dart';
import 'package:dating_app/app/presentation/pages/main/main_controller.dart';
import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:get/get.dart';

import '../../../data/models/subscription_package_model/subscription_package_model.dart';
import '../../../data/response/create_payment_response.dart';

class VnPayController extends GetxController {
  RxString avatarUrl = RxString('');
  Rx<UserModel?> currentUser = Get.find<MainController>().currentUser;
  RxInt indexChoose = 1.obs;
  final paymentRepository = Get.find<PaymentRepository>();
  Rx<CreatePaymentResponse?> createPaymentResponse = Rx(null);
  PaymentRequest paymentRequest = PaymentRequest();
  RxBool showWebView = true.obs;
  late SubscriptionPackageModel subPackage;
  Rx<PaymentModel> paymentModel = Rx(PaymentModel());
  Rx<bool?> isSuccess = Rx(null);
  final CommonController commonController = Get.find<CommonController>();

  @override
  Future<void> onInit() async {
    super.onInit();
    subPackage = Get.arguments as SubscriptionPackageModel;
    paymentRequest = PaymentRequest(
      userId: currentUser.value!.id,
      premiumPackage: subPackage.slug,
    );
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    createPaymentResponse.value =
        await paymentRepository.createPaymentLink(paymentRequest);
  }

  onReturnUrl(String url) async {
    final uri = Uri.parse(url);

    isSuccess.value = uri.queryParameters['vnp_ResponseCode'] == '00';

    Get.offAndToNamed(
      RouteList.paymentDetailRoute(
        id: createPaymentResponse.value?.paymentModel?.paymentId ?? '',
      ),
      parameters: {
        'isSuccess': isSuccess.value.toString(),
      },
    );

    /*try {
      commonController.startLoading();
      showWebView.value = false;
      final uri = Uri.parse(url);
      final res = await paymentRepository.getPaymentDetail(
        transactionId: uri.queryParameters['vnp_TxnRef']!,
      );
      isSuccess.value = uri.queryParameters['vnp_ResponseCode'] == '00';
      if (res.isLeft) {
        FunctionUtils.logWhenDebug(this, "leftleft");

        final errorResponse = res.left;
        SmartDialog.showToast(errorResponse.errorMessage ?? '');
      } else {
        FunctionUtils.logWhenDebug(this, "rightright");
        paymentModel.value = res.right.copyWith(
          status: isSuccess.isTrue!
              ? PaymentStatusType.success
              : PaymentStatusType.failed,
        );
        paymentModel.refresh();
      }
    } catch (e) {
      FunctionUtils.logWhenDebug(this, "onReturnUrl error: $e");
    } finally {
      commonController.stopLoading();
    }*/
  }
}
