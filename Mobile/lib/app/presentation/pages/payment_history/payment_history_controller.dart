import 'package:dating_app/app/common/configs/default_env.dart';
import 'package:dating_app/app/common/constants/data_constants.dart';
import 'package:dating_app/app/data/repositories/payment_repository.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../common/mixins/paging_mixin.dart';
import '../../../data/models/pagination.dart';
import '../../../data/models/payment/payment_model.dart';
import '../../../routes/app_pages.dart';
import '../../../widgets/loader_widget/loader_controller.dart';

class PaymentHistoriesController extends GetxController
    with BaseCommonMethodMixin {
  final PaymentRepository _paymentRepository = Get.find<PaymentRepository>();
  final CommonController _commonController = Get.find<CommonController>();
  PagingController<int, PaymentModel> paymentListController =
      PagingController(firstPageKey: 1);
  Rx<BaseStateStatus> dataState = Rx(BaseStateStatus.init);
  Pagination request = Pagination(
    limit: DefaultConfig.limitRequest,
    page: 1,
  );
  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    await getPaymentHistoryItems(1);
    paymentListController.addPageRequestListener((pageKey) {
      getPaymentHistoryItems(pageKey);
    });
  }

  getPaymentHistoryItems(int? offset) async {
    dataState.value = BaseStateStatus.loading;
    _commonController.startLoading();
    request = request.copyWith(page: offset);
    final result = await _paymentRepository.getPaymentHistory(request: request);

    pagingControllerOnLoad(
      request.page,
      paymentListController,
      result,
      onSuccess: (List<PaymentModel> list) {
        dataState.value = BaseStateStatus.success;
        _commonController.stopLoading();
      },
      onError: (String error) {
        dataState.value = BaseStateStatus.error;
        _commonController.stopLoading();
      },
    );
  }

  void onTapItem(PaymentModel item) {
    if (item.paymentId != null) {
      Get.toNamed(RouteList.paymentDetailRoute(id: item.paymentId!));
    }
  }

  @override
  void onClose() {
    paymentListController.dispose();
    super.onClose();
  }

  void onRefresh() {
    paymentListController.refresh();
  }
}
