import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'loader_constants.dart';
import 'loader_controller.dart';

class LoadingContainer extends StatelessWidget {
  final Widget? child;

  const LoadingContainer({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final controller = Get.find<CommonController>();

    return Stack(
      children: <Widget>[
        if (child != null) child!,
        WillPopScope(
          onWillPop: () {
            controller.stopLoading();
            return Future.value(true);
          },
          child: Obx(() {
            return Visibility(
                visible: controller.isLoading.isTrue,
                child: controller.isTopLoading.isTrue
                    ? Container(
                        key:
                            const ValueKey(LoaderConstants.loaderBackgroundKey),
                        height: mediaQuery.size.height,
                        width: mediaQuery.size.width,
                        color: Colors.black.withOpacity(
                            LoaderConstants.loaderBackgroundOpacity),
                        child: Center(
                          child: Container(
                            key: const ValueKey(
                                LoaderConstants.loaderImageContainerKey),
                            child: Material(
                              color: Colors.black26,
                              child: Center(
                                child: controller.isShowDialog.isTrue
                                    ? SizedBox()
                                    : _buildLoadingWidget(),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  top: LoaderConstants.loaderPaddingTop),
                              child: Container(
                                  alignment: Alignment.topCenter,
                                  color: Colors.transparent,
                                  child: Material(
                                    color: Colors.black26,
                                    child: Center(
                                      child: _buildLoadingWidget(),
                                    ),
                                  )))
                        ],
                      ));
          }),
        )
      ],
    );
  }

  Container _buildLoadingWidget() {
    return Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: CircularProgressIndicator(
          color: ColorUtils.primaryColor,
        ));
  }
}
