import 'package:flutter/material.dart';
import 'package:swipable_stack/swipable_stack.dart';

class SwipeDirectionColor {
  static const right = Color(0xff86ff71);
  static const left = Color(0xffE45A3C);
  static const up = Color.fromRGBO(83, 170, 232, 1);
  static const down = Color.fromRGBO(154, 85, 215, 1);
}

extension SwipeDirecionX on SwipeDirection {
  Color get color {
    switch (this) {
      case SwipeDirection.right:
        return SwipeDirectionColor.right;
      case SwipeDirection.left:
        return SwipeDirectionColor.left;
      case SwipeDirection.up:
        return SwipeDirectionColor.up;
      case SwipeDirection.down:
        return SwipeDirectionColor.down;
    }
  }
}
