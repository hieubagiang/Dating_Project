import 'package:dating_app/app/routes/app_pages.dart';
import 'package:dating_app/app/widgets/widgets_common.dart';
import 'package:flutter/material.dart';

import '../../../common/base/base_view_view_model.dart';
import 'admin_controller.dart';

class AdminScreen extends BaseView<AdminController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: ButtonWidget(
                onPress: () {
                  controller.addNewUser();
                },
                label: 'Add new user',
              ),
            ),
            SizedBox(
              width: 200,
              child: ButtonWidget(
                onPress: () {
                  controller.removeMockUser();
                },
                label: 'Remove mock user',
              ),
            ),
            SizedBox(
              width: 200,
              child: ButtonWidget(
                onPress: () {
                  controller.removeNullUser();
                },
                label: 'Remove null user',
              ),
            ),SizedBox(
              width: 200,
              child: ButtonWidget(
                onPress: () async {
                 final result =  await Get.toNamed(RouteList.paymentScreen);
                 print(result);
                },
                label: 'paymentScreen',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
