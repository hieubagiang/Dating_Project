import 'package:flutter/material.dart';
import 'package:dating_app/app/common/assets/constans.dart';

class AssetImageWidget extends StatelessWidget {
  const AssetImageWidget();

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      placeholderAsset,
      fit: BoxFit.cover,
    );
  }
}
