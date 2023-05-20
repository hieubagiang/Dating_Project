import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Use when search or lazy loading list item
class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("no_data".tr);
  }
}
