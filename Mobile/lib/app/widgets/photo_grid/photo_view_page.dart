import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/widgets/loader_widget/loader_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatefulWidget {
  final List<String>? imageUrls;
  final int currentIndex;
  final List<String>? imgIds;

  PhotoViewPage({this.imageUrls, required this.currentIndex, this.imgIds});

  @override
  _PhotoViewPageState createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  bool _showCloseButton = false;
  late PageController _pageController;
  late int viewIndex = widget.currentIndex;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: InkWell(
        onTap: () {
          setState(() {
            _showCloseButton = !_showCloseButton;
          });
        },
        child: SafeArea(
          child: Container(
            height: 1.sh,
            color: Colors.red,
            child: Stack(
              children: <Widget>[
                PhotoViewGallery.builder(
                  itemCount: widget.imageUrls!.length,
                  pageController: _pageController,
                  scrollPhysics: const BouncingScrollPhysics(),
                  backgroundDecoration: BoxDecoration(color: Colors.black),
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                        imageProvider: CachedNetworkImageProvider(
                          widget.imageUrls![index],
                          cacheKey: '${widget.imageUrls![index]}_hd',
                        ),
                        minScale: PhotoViewComputedScale.contained,
                        maxScale: PhotoViewComputedScale.covered,
                        errorBuilder: (context, index, stackTrace) {
                          return Icon(Icons.error);
                        });
                  },
                  loadingBuilder: (context, event) => Center(
                    child: CircularProgressIndicator(
                      color: ColorUtils.primaryColor,
                    ),
                  ),
                  onPageChanged: (value) {
                    viewIndex = value;
                  },
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Container(
                      width: SizeUtils.iconSize,
                      height: SizeUtils.iconSize,
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: SizeUtils.iconSize,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _buildSaveWidget(),
    );
  }

  Widget _buildSaveWidget() {
    return GestureDetector(
      onTap: () async {
        await onTapSave();
      },
      child: Container(
        margin: EdgeInsets.all(SpaceUtils.spaceMedium),
        padding: EdgeInsets.symmetric(
            horizontal: SpaceUtils.spaceMedium,
            vertical: SpaceUtils.spaceSmall),
        decoration: BoxDecoration(
            color: ColorUtils.primaryColor,
            borderRadius: BorderRadius.circular(BorderUtils.borderButtonLarge)),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(
              Icons.file_download,
              color: ColorUtils.whiteColor,
            ),
            SizedBox(
              width: SpaceUtils.spaceSmall,
            ),
            Text(
              'save'.tr,
              style: StyleUtils.style18Medium
                  .copyWith(color: ColorUtils.whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> onTapSave() async {
    final controller = Get.find<CommonController>();
    controller.showLoadingDialog();
    final result = await FileUtils.saveImage(widget.imageUrls![viewIndex]);
    controller.hideDialog();
    String message = '';
    if (result) {
      message = 'image_saved'.tr;
    } else {
      message = 'image_save_failed'.tr;
    }
    FunctionUtils.showToast(message);
  }
}
