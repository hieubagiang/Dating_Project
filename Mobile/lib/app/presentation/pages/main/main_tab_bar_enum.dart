import 'package:dating_app/app/common/utils/icon_utils.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class TabBarTypeEnum {
  static TabBarType getTabBarType(int id) {
    return TabBarType.values.where((value) => value.id == id).first;
  }
}

enum TabBarType { search, matches, message, settings }

extension TabBarTypeExtension on TabBarType {
  int get id {
    switch (this) {
      case TabBarType.search:
        return 0;
      case TabBarType.matches:
        return 1;
      case TabBarType.message:
        return 2;
      case TabBarType.settings:
        return 3;
    }
  }

  String get label {
    switch (this) {
      case TabBarType.search:
        return 'feed'.tr;
      case TabBarType.matches:
        return 'matches'.tr;
      case TabBarType.message:
        return 'message'.tr;
      case TabBarType.settings:
        return 'settings'.tr;
    }
  }

  String get iconActive {
    switch (this) {
      case TabBarType.search:
        return IconUtils.icSearchActive;
      case TabBarType.matches:
        return IconUtils.icMatchesActive;
      case TabBarType.message:
        return IconUtils.icMessageActive;
      case TabBarType.settings:
        return IconUtils.icSettingActive;
    }
  }

  String get iconInActive {
    switch (this) {
      case TabBarType.search:
        return IconUtils.icSearchInActive;
      case TabBarType.matches:
        return IconUtils.icMatchesInActive;
      case TabBarType.message:
        return IconUtils.icMessageInActive;
      case TabBarType.settings:
        return IconUtils.icSettingInActive;
    }
  }
}
