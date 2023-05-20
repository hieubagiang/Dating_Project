import 'dart:async';

import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/widgets/dialogs_widget/custom_alert_dialog_widget.dart';
import 'package:dating_app/app/widgets/dialogs_widget/custom_cupertion_action_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'base_controller.dart';

bool hasDialog = false;

class BaseCommonWidgets implements _CommonWidgetsInterface {
  Timer? timer;

  @override
  void hideDialog() {
    if (Get.isDialogOpen ?? false) {
      hasDialog = false;
      Get.back();
      timer?.cancel();
    }
  }

  @override
  void showLoadingDialog({Function? onTimeOut}) {
    hideDialog();
    Get.dialog(
        Material(
          color: Colors.black26,
          child: Center(
            child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
                child: CircularProgressIndicator(
                  color: ColorUtils.primaryColor,
                )),
          ),
        ),
        barrierDismissible: false,
        name: "Loading Dialog");
  }

  //EXAMPLE
  @override
  void showDialogMessage(
      {required String message, Function()? onClick, String? title}) {
    if (message.isEmpty) return;
    hideDialog();
    // set up the button
    Widget okButton = IntrinsicHeight(
      child: ElevatedButton(
        child: Text(
          "ok".tr.toUpperCase(),
          style:
              StyleUtils.style16Medium.copyWith(color: ColorUtils.primaryColor),
        ),
        onPressed: () {
          Get.back();
          if (onClick != null) {
            onClick();
          }
        },
      ),
    );

    Dialog customDialog = Dialog(
      backgroundColor: ColorUtils.whiteColor,
      // your color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceUtils.spaceMedium)),
      // change 40 to your desired radius
      child: CustomAlertDialog(
        title: title,
        message: message,
        rightActionWidget: okButton,
      ),
    );
    // show the dialog
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: customDialog);
        },
      );
    }
  }

  @override
  void showBottomDialog(
      {String? title,
      String? message,
      List<Widget>? actions,
      Widget? cancelButton}) {
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) => CustomBottomDialog(
              title: title,
              message: message,
              actions: actions,
              cancelButton: cancelButton,
            ));
  }

  @override
  void showConfirmDialog(
      {String? title, String? message, Function()? onConfirm}) {
    Widget confirmWidget = ElevatedButton(
      child: Text(
        "ok".tr.toUpperCase(),
        style: StyleUtils.style16Medium
            .copyWith(color: ColorUtils.dialogButtonColor),
      ),
      onPressed: () {
        Get.back();
        onConfirm?.call();
      },
    );
    Widget cancelWidget = ElevatedButton(
      child: Text(
        "cancel".tr.toUpperCase(),
        style: StyleUtils.style16Medium
            .copyWith(color: ColorUtils.dialogButtonColor),
      ),
      onPressed: () {
        Get.back();
      },
    );
    Dialog customDialog = Dialog(
      backgroundColor: ColorUtils.whiteColor,
      // your color
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SpaceUtils.spaceMedium)),
      // change 40 to your desired radius
      child: CustomAlertDialog(
        message: message ?? '',
        title: title ?? '',
        leftActionWidget: cancelWidget,
        rightActionWidget: confirmWidget,
      ),
    );
    // show the dialog
    if (Get.context != null) {
      showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: customDialog);
        },
      );
    }
  }
}

abstract class _CommonWidgetsInterface {
  void showLoadingDialog();

  void hideDialog();

  void showDialogMessage(
      {String? title, required String message, Function()? onClick});

  void showConfirmDialog(
      {String? title, String? message, Function()? onConfirm});

  void showBottomDialog();
}
