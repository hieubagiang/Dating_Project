import 'package:get/get_utils/src/extensions/internacionalization.dart';

class HobbyTypeEnum {
  static List<String> get labels {
    List<String> labels = [];
    for (var element in HobbyType.values) {
      labels.add(element.label);
    }
    return labels;
  }

  static List<HobbyType> get list {
    return HobbyType.values.toList();
  }

  static HobbyType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return HobbyType.values.where((value) => value.id == id).first;
  }
}

enum HobbyType {
  photography,
  shopping,
  karaoke,
  yoga,
  cooking,
  tennis,
  run,
  swimming,
  art,
  travelling,
  extreme,
  music,
  drink,
  videoGames
}

extension HobbyTypeEnumExtension on HobbyType {
  int get id {
    switch (this) {
      case HobbyType.photography:
        return 1;
      case HobbyType.shopping:
        return 2;
      case HobbyType.karaoke:
        return 3;
      case HobbyType.yoga:
        return 4;
      case HobbyType.cooking:
        return 5;
      case HobbyType.tennis:
        return 6;
      case HobbyType.run:
        return 7;
      case HobbyType.swimming:
        return 8;
      case HobbyType.art:
        return 9;
      case HobbyType.travelling:
        return 10;
      case HobbyType.extreme:
        return 11;
      case HobbyType.music:
        return 12;
      case HobbyType.drink:
        return 13;
      case HobbyType.videoGames:
        return 14;
    }
  }

  String get label {
    switch (this) {
      case HobbyType.photography:
        return 'hobbies.photography'.tr;
      case HobbyType.shopping:
        return 'hobbies.shopping'.tr;
      case HobbyType.karaoke:
        return 'hobbies.karaoke'.tr;
      case HobbyType.yoga:
        return 'hobbies.yoga'.tr;
      case HobbyType.cooking:
        return 'hobbies.cooking'.tr;
      case HobbyType.tennis:
        return 'hobbies.tennis'.tr;
      case HobbyType.run:
        return 'hobbies.run'.tr;
      case HobbyType.swimming:
        return 'hobbies.swimming'.tr;
      case HobbyType.art:
        return 'hobbies.art'.tr;
      case HobbyType.travelling:
        return 'hobbies.travelling'.tr;
      case HobbyType.extreme:
        return 'hobbies.extreme'.tr;
      case HobbyType.music:
        return 'hobbies.music'.tr;
      case HobbyType.drink:
        return 'hobbies.drink'.tr;
      case HobbyType.videoGames:
        return 'hobbies.videoGames'.tr;
    }
  }
}
