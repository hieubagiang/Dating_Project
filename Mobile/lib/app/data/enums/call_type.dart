import 'package:get/get.dart';

enum CallType { voice, video }

class CallTypeEnum {
  static List<CallType> get list {
    return CallType.values.toList();
  }

  static CallType? getType(String? constantValue) {
    if (constantValue == null) {
      return CallType.voice;
    }
    return CallType.values
        .where((value) => value.constantValue == constantValue)
        .first;
  }
}

extension CallTypeEnumExtension on CallType {
  String get constantValue {
    switch (this) {
      case CallType.voice:
        return 'voice';
      case CallType.video:
        return 'video';
    }
  }

  String get label {
    switch (this) {
      case CallType.voice:
        return 'voice_call'.tr;
      case CallType.video:
        return 'video_call'.tr;
    }
  }
}
