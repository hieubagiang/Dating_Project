class PaymentStatusTypeEnum {
  static List<PaymentStatusType> get list {
    return PaymentStatusType.values.toList();
  }

  static PaymentStatusType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return PaymentStatusType.values.where((value) => value.id == id).first;
  }
}

enum PaymentStatusType { pending, success, failed }

extension PaymentStatusTypeEnumExtension on PaymentStatusType {
  int get id {
    switch (this) {
      case PaymentStatusType.pending:
        return 1;
      case PaymentStatusType.success:
        return 2;
      case PaymentStatusType.failed:
        return 3;
    }
  }

  String get name {
    switch (this) {
      case PaymentStatusType.pending:
        return 'pending';
      case PaymentStatusType.success:
        return 'success';
      case PaymentStatusType.failed:
        return 'failed';
    }
  }
}
