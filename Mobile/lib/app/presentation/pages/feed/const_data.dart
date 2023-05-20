import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ParentClassType {
  lounge,
  chat,
  editProfile,
}

class BottomButtonData {
  IconData iconData;
  Color iconColor;

  BottomButtonData(this.iconData, this.iconColor);
}

List<BottomButtonData> bottomIconDataList = [
  BottomButtonData(FontAwesomeIcons.redoAlt, Colors.yellow[800]!),
  BottomButtonData(FontAwesomeIcons.times, Colors.redAccent),
  BottomButtonData(FontAwesomeIcons.comments, Colors.blue[400]!),
  BottomButtonData(FontAwesomeIcons.solidHeart, Colors.redAccent),
  BottomButtonData(FontAwesomeIcons.bolt, Colors.purple[400]!),
];
