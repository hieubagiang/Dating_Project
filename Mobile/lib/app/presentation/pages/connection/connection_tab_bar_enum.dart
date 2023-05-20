import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MatchTabBarTypeEnum {
  static MatchTabBarType getTabBarType(int id) {
    return MatchTabBarType.values.where((value) => value.id == id).first;
  }
}

enum MatchTabBarType { chosen, liked, topPicks }

extension TabBarTypeExtension on MatchTabBarType {
  int get id {
    switch (this) {
      case MatchTabBarType.chosen:
        return 0;
      case MatchTabBarType.liked:
        return 1;
      case MatchTabBarType.topPicks:
        return 2;
    }
  }

  String get label {
    switch (this) {
      case MatchTabBarType.chosen:
        return 'liked_me'.tr;
      case MatchTabBarType.liked:
        return 'my_likes'.tr;
      case MatchTabBarType.topPicks:
        return 'top_picks'.tr;
      default:
        return '';
    }
  }
}
