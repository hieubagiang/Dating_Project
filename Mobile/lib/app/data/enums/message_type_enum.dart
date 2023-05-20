import 'package:get/get_utils/src/extensions/internacionalization.dart';

class MessageTypeEnum {
  static List<String> get labels {
    List<String> labels = [];
    for (var element in MessageType.values) {
      labels.add(element.label);
    }
    return labels;
  }

  static List<MessageType> get list {
    return MessageType.values.toList();
  }

  static MessageType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return MessageType.values.where((value) => value.id == id).first;
  }
}

enum MessageType { normal, pending, system, call }

extension MessageTypeEnumExtension on MessageType {
  int get id {
    switch (this) {
      case MessageType.normal:
        return 1;
      case MessageType.pending:
        return 2;
      case MessageType.system:
        return 3;
      case MessageType.call:
        return 4;
    }
  }

  String get label {
    switch (this) {
      case MessageType.normal:
        return 'normal'.tr;
      case MessageType.pending:
        return 'pending'.tr;
      case MessageType.system:
        return 'system'.tr;
      case MessageType.call:
        return 'system'.tr;
    }
  }

  String get constValue {
    switch (this) {
      case MessageType.normal:
        return 'normal';
      case MessageType.pending:
        return 'pending';
      case MessageType.system:
        return 'system';
      case MessageType.call:
        return 'call';
    }
  }
}
