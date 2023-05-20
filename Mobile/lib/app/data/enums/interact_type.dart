import 'package:dating_app/app/presentation/pages/feed/const_data.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

class InteractTypeEnum {
  static List<String> get labels {
    List<String> labels = [];
    for (var element in InteractType.values) {
      labels.add(element.label);
    }
    return labels;
  }

  static List<InteractType> get list {
    return InteractType.values.toList();
  }

  static List<InteractType> get listExceptUndo {
    return [InteractType.dislike, InteractType.like, InteractType.superLike];
  }

  static InteractType? getType(int? id) {
    if (id == null) {
      return null;
    }
    return InteractType.values.where((value) => value.id == id).first;
  }
}

enum InteractType { undo, dislike, like, superLike, matched, blocked }

extension InteractTypeEnumExtension on InteractType {
  int get id {
    switch (this) {
      case InteractType.undo:
        return 0;
      case InteractType.dislike:
        return 1;
      case InteractType.like:
        return 2;
      case InteractType.superLike:
        return 3;
      case InteractType.matched:
        return 4;
      case InteractType.blocked:
        return 5;
    }
  }

  String get label {
    switch (this) {
      case InteractType.undo:
        return 'undo'.tr;
      case InteractType.dislike:
        return 'dislike'.tr;
      case InteractType.like:
        return 'like'.tr;
      case InteractType.superLike:
        return 'supper_like'.tr;
      case InteractType.matched:
        return 'matched'.tr;
      case InteractType.blocked:
        return 'blocked'.tr;
    }
  }

  IconData get icon {
    switch (this) {
      case InteractType.undo:
        return FontAwesomeIcons.redoAlt;
      case InteractType.dislike:
        return FontAwesomeIcons.times;
      case InteractType.like:
        return FontAwesomeIcons.solidHeart;
      case InteractType.superLike:
        return FontAwesomeIcons.solidStar;
      default:
        return FontAwesomeIcons.solidStar;
    }
  }

  BottomButtonData get bottomButtonData {
    switch (this) {
      case InteractType.undo:
        return BottomButtonData(FontAwesomeIcons.redoAlt, Colors.yellow[800]!);
      case InteractType.dislike:
        return BottomButtonData(FontAwesomeIcons.times, Colors.redAccent);
      case InteractType.like:
        return BottomButtonData(FontAwesomeIcons.solidHeart, Colors.redAccent);
      case InteractType.superLike:
        return BottomButtonData(FontAwesomeIcons.solidStar, Colors.blue[400]!);
      default:
        return BottomButtonData(FontAwesomeIcons.solidStar, Colors.blue[400]!);
    }
  }
}
