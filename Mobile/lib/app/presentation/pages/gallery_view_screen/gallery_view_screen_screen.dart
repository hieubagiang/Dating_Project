import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'gallery_view_screen_controller.dart';

class GalleryViewScreenScreen extends StatefulWidget {
  const GalleryViewScreenScreen({super.key});

  @override
  State<GalleryViewScreenScreen> createState() =>
      _GalleryViewScreenScreenState();
}

class _GalleryViewScreenScreenState extends State<GalleryViewScreenScreen> {
  final controller = Get.find<GalleryViewScreenController>();

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    Get.delete<GalleryViewScreenController>();
    super.dispose();
  }
}
