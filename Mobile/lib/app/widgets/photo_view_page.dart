import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

import 'appbar_widget/appbar_widget.dart';

class PhotoViewPage extends StatefulWidget {
  final List<String>? imageUrls;
  final int currentIndex;

  PhotoViewPage(this.imageUrls, this.currentIndex);

  @override
  PhotoViewPageState createState() => PhotoViewPageState();
}

class PhotoViewPageState extends State<PhotoViewPage> {
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
      backgroundColor: ColorUtils.secondaryColor,
      body: SafeArea(
        child: InkWell(
          onTap: () {
            setState(() {
              _showCloseButton = !_showCloseButton;
            });
          },
          child: Stack(
            children: <Widget>[
              PhotoViewGallery.builder(
                itemCount: widget.imageUrls!.length,
                pageController: _pageController,
                scrollPhysics: const BouncingScrollPhysics(),
                backgroundDecoration:
                    BoxDecoration(color: ColorUtils.blackColor),
                builder: (BuildContext context, int index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(
                      widget.imageUrls![index],
                    ),
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.covered,
                  );
                },
                loadingBuilder: (context, event) => Center(
                  child: Opacity(
                    opacity: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes!,
                    child: CircularProgressIndicator(),
                  ),
                ),
                onPageChanged: (value) {
                  viewIndex = value;
                },
              ),
              Positioned(
                top: SpaceUtils.spaceMedium * 2,
                left: SpaceUtils.spaceSmall,
                child: AppBarButton(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: ColorUtils.primaryColor, width: 1.5)),
                    child: SvgPicture.asset(
                      IconUtils.icBack,
                      height: SizeUtils.iconSizeLarge,
                      width: SizeUtils.iconSizeLarge,
                      color: ColorUtils.primaryColor,
                    ),
                  ),
                  height: SizeUtils.iconSizeLarge,
                  width: SizeUtils.iconSizeLarge,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
