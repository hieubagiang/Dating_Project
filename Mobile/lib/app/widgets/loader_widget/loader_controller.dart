import 'dart:async';

import 'package:dating_app/app/common/base/base_common_widgets.dart';
import 'package:dating_app/app/common/utils/external_lib.dart';
import 'package:dating_app/app/common/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loading_logo_widget.dart';

class CommonController extends GetxController with BaseCommonWidgets {
  RxBool isLoading = RxBool(false);
  RxBool isShowDialog = RxBool(false);
  RxBool isTopLoading = RxBool(true);
  RxList<Widget> dialogQueue = RxList.empty();

  void startLoading({Function? onTimeOut}) {
    SmartDialog.showLoading(
      backDismiss: true,
      displayTime: const Duration(seconds: 10),
      builder: (context) {
        return Center(
          child: Container(
            padding: EdgeInsets.all(12.w),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: const LoadingLogoWidget(),
          ),
        );
      },
    );
    FunctionUtils.logWhenDebug(this, 'Start Loading');
  }

  void stopLoading() {
    SmartDialog.dismiss(status: SmartStatus.loading);
    hideLoading();
    FunctionUtils.logWhenDebug(this, 'Stop Loading');
  }

  Future<dynamic> showDialog({
    required Widget dialog,
    Function()? onSubmitted,
  }) async {
    if (isLoading.isTrue) {
      stopLoading();
    }
    final result = await FunctionUtils.showDialogCustom(
        context: Get.context!, dialog: dialog);
    return result;
  }

  void hideLoading() {
    timer?.cancel();
  }
}
