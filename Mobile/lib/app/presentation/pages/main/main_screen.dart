import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/core/widgets/keep_alive_wrapper.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_screen.dart';
import 'package:dating_app/app/presentation/pages/feed/feed_screen.dart';
import 'package:dating_app/app/presentation/pages/message/message_list/message_list_screen.dart';
import 'package:dating_app/app/presentation/pages/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'main_controller.dart';
import 'main_tab_bar_enum.dart';
import 'widgets/custom_nav_bar_widget.dart';

class MainScreen extends BaseView<MainController> {
  List<Widget> _buildScreens() {
    return [
      KeepAliveWrapper(child: FeedScreen()),
      KeepAliveWrapper(child: MatchesScreen()),
      KeepAliveWrapper(child: MessageListScreen()),
      KeepAliveWrapper(child: ProfileScreen())
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return TabBarType.values
        .map(
          (e) => PersistentBottomNavBarItem(
            icon: Obx(() {
              return SvgPicture.asset(
                controller.selectedIndex.value == e.id
                    ? e.iconActive
                    : e.iconInActive,
                height: SizeUtils.iconSize,
                width: SizeUtils.iconSize,
              );
            }),
            activeColorPrimary: ColorUtils.primaryColor,
            inactiveColorPrimary: ColorUtils.greyColor,
          ),
        )
        .toList();
  }

  @override
  Widget vBuilder(BuildContext context) {
    return Obx(() {
      return PersistentTabView.custom(
        context,
        controller: controller.tabController,
        screens: _buildScreens(),
        itemCount: TabBarType.values.length,
        confineInSafeArea: true,
        backgroundColor: Colors.white,
        // Default is Colors.white.
        handleAndroidBackButtonPress: true,
        onWillPop: (context) async {
          return Future.value(true);
        },
        // Default is true.
        resizeToAvoidBottomInset: true,
        // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
        stateManagement: true,
        // Default is true.
        hideNavigationBarWhenKeyboardShows: true,
        // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
        hideNavigationBar: controller.isInitDone.isFalse,
        screenTransitionAnimation: ScreenTransitionAnimation(
          // Screen transition animation on change of selected tab.
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: 200),
        ),
        customWidget: CustomNavBarWidget(
          // Your custom widget goes here
          items: _navBarsItems(),
          selectedIndex: controller.selectedIndex.value,
          onItemSelected: controller.onChangeTab,
        ),
      );
    });
  }
}
