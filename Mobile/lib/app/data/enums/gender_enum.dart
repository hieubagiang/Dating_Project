import 'package:collection/collection.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class GenderTypeEnum {
  static List<String> get labels {
    List<String> labels = [];
    for (var element in GenderType.values) {
      labels.add(element.label);
    }
    return labels;
  }

  static List<GenderType> get list {
    return GenderType.values.toList();
  }

  static GenderType? getType(String? type) {
    if (type == null) {
      return null;
    }
    return GenderType.values
        .where((value) => value.constValue == type)
        .firstOrNull;
  }
}

enum GenderType { male, female }

extension GenderTypeEnumExtension on GenderType {
  int get id {
    switch (this) {
      case GenderType.male:
        return 1;
      case GenderType.female:
        return 2;
    }
  }

  GenderType get interestedInGender {
    switch (this) {
      case GenderType.male:
        return GenderType.female;
      case GenderType.female:
        return GenderType.male;
    }
  }

  String get label {
    switch (this) {
      case GenderType.male:
        return 'male'.tr;
      case GenderType.female:
        return 'female'.tr;
    }
  }

  String get constValue {
    switch (this) {
      case GenderType.male:
        return 'male';
      case GenderType.female:
        return 'female';
    }
  }
}
