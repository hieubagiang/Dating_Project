import 'package:get/get_utils/src/extensions/internacionalization.dart';

class AdsPremiumTypeEnum {
  static List<String> get labels {
    List<String> labels = [];
    for (var element in AdsPremiumType.values) {
      labels.add(element.label);
    }
    return labels;
  }

  static List<AdsPremiumType> get list {
    return AdsPremiumType.values.toList();
  }

  static AdsPremiumType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return AdsPremiumType.values.where((value) => value.id == id).first;
  }
}

enum AdsPremiumType { chosen, like }

extension AdsPremiumTypeEnumExtension on AdsPremiumType {
  int get id {
    switch (this) {
      case AdsPremiumType.chosen:
        return 1;
      case AdsPremiumType.like:
        return 2;
    }
  }

  AdsPremiumType get interestedInAdsPremium {
    switch (this) {
      case AdsPremiumType.chosen:
        return AdsPremiumType.like;
      case AdsPremiumType.like:
        return AdsPremiumType.chosen;
    }
  }

  String get label {
    switch (this) {
      case AdsPremiumType.chosen:
        return 'who-like-u'.tr;
      case AdsPremiumType.like:
        return 'who-u-like'.tr;
    }
  }

  String get constValue {
    switch (this) {
      case AdsPremiumType.chosen:
        return 'male';
      case AdsPremiumType.like:
        return 'female';
    }
  }
}
