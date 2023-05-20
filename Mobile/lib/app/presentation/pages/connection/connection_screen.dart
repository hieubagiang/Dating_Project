import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/core/widgets/index.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/liked_tab/liked_tab_screen.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/top_picks_tab/top_picks_tab_screen.dart';
import 'package:dating_app/app/widgets/header.dart';
import 'package:flutter/material.dart';

import 'connection_controller.dart';
import 'connection_tab_bar_enum.dart';
import 'widgets/chosen_tab/chosen_tab_screen.dart';

class MatchesScreen extends BaseView<MatchesController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppbarWidgetCustom(
              name: 'connection'.tr,
            ),
            Obx(() {
              return controller.isInitDone.isFalse
                  ? Container(
                      child: Text(
                        'isInitDone.isFalse',
                        style: StyleUtils.style14Normal,
                      ),
                    )
                  : Expanded(
                      child: Column(
                        children: [
                          Container(
                              child: TabBar(
                            labelPadding: EdgeInsets.zero,
                            indicatorColor: ColorUtils.primaryColor,
                            labelColor: ColorUtils.primaryColor,
                            unselectedLabelColor: ColorUtils.primaryTextColor,
                            labelStyle: StyleUtils.style14Bold,
                            unselectedLabelStyle: StyleUtils.style14Bold,
                            controller: controller.tabController,
                            tabs: myTabs(),
                          )),
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  color: Colors.white,
                                  child: TabBarView(
                                      physics: const BouncingScrollPhysics(),
                                      controller: controller.tabController,
                                      children: [
                                        KeepAliveWrapper(
                                          child: ChosenTabScreen(),
                                        ),
                                        KeepAliveWrapper(
                                          child: LikedTabScreen(),
                                        ),
                                        KeepAliveWrapper(
                                          child: TopPicksTabScreen(),
                                        ),
                                      ]),
                                ),
                                /* Positioned(
                bottom: SpaceUtils.spaceLarge,
                right: SpaceUtils.spaceLarge,
                child: )*/
                              ],
                            ),
                          ),
                          // BottomWidget(
                          //     notificationNumber: 5, onClickChat: () {}, onClickMemo: () {}),
                        ],
                      ),
                    );
            })
          ],
        ),
      ),
    );
  }

  List<Widget> myTabs() {
    return [
      _individualTab(
        text: MatchTabBarType.chosen.label,
      ),
      _individualTab(text: MatchTabBarType.liked.label),
      _individualTab(text: MatchTabBarType.topPicks.label),
    ];
  }

  Widget _individualTab({required String text}) {
    return Tab(
      child: Container(
        alignment: Alignment.center,
        height: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Text(text),
      ),
    );
  }
}
