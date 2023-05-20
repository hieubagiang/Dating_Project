import 'package:dating_app/app/common/constants/constants.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'widget_state.dart';

export 'package:get/get.dart';

/// createdby Daewu Bintara
/// Friday, 1/29/21

///
/// --------------------------------------------
/// [Example]
///
/// class HomeController extends BaseController {
///
///   var count = 0.obs;
///
///   @override
///   void onInit() {
///     super.onInit();
///   }
///
///   void increment() => count ++;
///
/// }
///
/// RECOMENDED FOR your [Controller].
/// Please extends to your [Controller].
/// read the [Example] above.
class BaseController extends SuperController
    with WidgetState, ScreenState, FunctionUtils {
  final box = GetStorage();
  bool withScrollController = false;
  late ScrollController scrollController;
  RxBool isLoadMore = false.obs;
  bool isEnableLoadMore = false;
  int _lastTimeClick = 0;

  void setEnableScrollController(bool value) => withScrollController = value;

  @override
  void onInit() {
    super.onInit();
    if (withScrollController) {
      FunctionUtils.logWhenDebug(
          "SCROLL CONTROLLER ENABLE on ${Get.currentRoute}",
          withScrollController.toString());
      scrollController = ScrollController();
      scrollController.addListener(_scrollListener);
    }
  }

  void onLoadMore() {
    isLoadMore.value = false;
  }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      if (isEnableLoadMore && !isLoadMore.value) {
        isLoadMore.value = true;
        onLoadMore();
      }
    }
  }

  bool isDoubleClick() {
    var timeNow = DateTime.now().millisecondsSinceEpoch;
    print((timeNow - _lastTimeClick).abs().toString());
    if ((timeNow - _lastTimeClick).abs() >= ConstantsUtils.clickDelay) {
      _lastTimeClick = timeNow;
      return false;
    }
    return true;
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

  void logWhenDebug(dynamic object, String message) {
    FunctionUtils.logWhenDebug(object, message);
  }
}
