import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:get/get.dart';

import '../../../common/utils/index.dart';
import '../../../data/enums/payment_status_enum.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../../data/repositories/payment_repository.dart';
import '../../../widgets/loader_widget/loader_controller.dart';

class PaymentDetailController extends GetxController {
  Rx<PaymentModel> paymentModel = Rx(PaymentModel());
  final CommonController commonController = Get.find<CommonController>();
  final paymentRepository = Get.find<PaymentRepository>();
  Rx<BaseStateStatus> baseStateStatus = Rx(BaseStateStatus.init);

  @override
  Future<void> onReady() async {
    super.onReady();
    final paymentId = Get.parameters['id'] ?? '';
    final isSuccess = Get.parameters['isSuccess'];
    final res = await paymentRepository.getPaymentDetail(
      paymentId: paymentId,
    );

    res.fold((left) {
      FunctionUtils.logWhenDebug(this, "leftleft");
      SmartDialog.showToast(left.errorMessage ?? '');
      baseStateStatus.value = BaseStateStatus.error;
    }, (right) {
      paymentModel.value = isSuccess != null
          ? right.copyWith(
              status: isSuccess == 'true'
                  ? PaymentStatusType.success
                  : PaymentStatusType.failed)
          : right;
      baseStateStatus.value = BaseStateStatus.success;
    });
  }
}
