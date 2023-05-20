import 'package:get/get_utils/src/extensions/internacionalization.dart';

class InterestedGenderTypeEnum {
  static List<String> get labels {
    List<String> labels = [];
    for (var element in InterestedGenderType.values) {
      labels.add(element.label);
    }
    return labels;
  }

  static List<InterestedGenderType> get list {
    return InterestedGenderType.values.toList();
  }

  static InterestedGenderType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return InterestedGenderType.values.where((value) => value.id == id).first;
  }
}

enum InterestedGenderType { male, female, both }

extension InterestedGenderTypeEnumExtension on InterestedGenderType {
  int get id {
    switch (this) {
      case InterestedGenderType.male:
        return 1;
      case InterestedGenderType.female:
        return 2;
      case InterestedGenderType.both:
        return 3;
    }
  }

  String get label {
    switch (this) {
      case InterestedGenderType.male:
        return 'male'.tr;
      case InterestedGenderType.female:
        return 'female'.tr;
      case InterestedGenderType.both:
        return 'both'.tr;
    }
  }
}
