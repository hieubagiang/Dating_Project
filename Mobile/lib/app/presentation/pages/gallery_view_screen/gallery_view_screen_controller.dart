import 'package:get/get.dart';

// class Args
class GalleryViewScreenArgs {
  final List<String>? imageUrls;
  final int currentIndex;
  final List<String>? imgIds;

  GalleryViewScreenArgs({
    this.imageUrls,
    required this.currentIndex,
    this.imgIds,
  });
}

class GalleryViewScreenController extends GetxController {
  late final List<String>? imageUrls;
  late final int currentIndex;
  late final List<String>? imgIds;

  @override
  void onInit() {
    super.onInit();
    // get data from arguments
    final args = Get.arguments as GalleryViewScreenArgs;
    imageUrls = args.imageUrls;
    currentIndex = args.currentIndex;
    imgIds = args.imgIds;
  }

  @override
  void onReady() {
    super.onReady();
  }
}
