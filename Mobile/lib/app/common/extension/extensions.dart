import 'dart:async';

import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:get/get.dart';

export 'file_extension.dart';
export 'num_extension.dart';
export 'string_extension.dart';

extension ProgressDialogFutureExt<T> on Future<T> {
  Future<T> withProgressDialog() {
    Get.find<CommonController>().startLoading();
    return whenComplete(() => Get.find<CommonController>().stopLoading());
  }
}

extension StreamSubscriptionExtension on StreamSubscription {
  void addToList(List<StreamSubscription> list) => list.add(this);
}
