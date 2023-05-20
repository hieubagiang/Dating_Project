class SubscriptionTypeEnum {
  static List<SubscriptionType> get list {
    return SubscriptionType.values.toList();
  }

  static SubscriptionType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return SubscriptionType.values.where((value) => value.id == id).first;
  }
}

enum SubscriptionType { aYear, halfOfYear, aMonth }

extension SubscriptionTypeEnumExtension on SubscriptionType {
  int get id {
    switch (this) {
      case SubscriptionType.aMonth:
        return 3;
      case SubscriptionType.halfOfYear:
        return 2;
      case SubscriptionType.aYear:
        return 1;
    }
  }

  String get cost {
    switch (this) {
      case SubscriptionType.aMonth:
        return '15,000 đ';
      case SubscriptionType.halfOfYear:
        return '35,000 đ';
      case SubscriptionType.aYear:
        return '50,000 đ';
    }
  }

  String get time {
    switch (this) {
      case SubscriptionType.aMonth:
        return '1 tháng';
      case SubscriptionType.halfOfYear:
        return '6 tháng';
      case SubscriptionType.aYear:
        return '12 tháng';
    }
  }
}
