import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../gen/assets.gen.dart';
import '../common/constants/constants.dart';

///Use for Network Image
class CachedImageWidget extends StatelessWidget {
  final String url;
  final Alignment alignment;
  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusCustom;
  final BoxShape? shape;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;

  const CachedImageWidget({
    Key? key,
    required this.url,
    this.borderRadius,
    this.borderRadiusCustom,
    this.alignment = Alignment.topLeft,
    this.fit,
    this.shape,
    this.width,
    this.height,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheKey: url,
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: shape == null
              ? (borderRadiusCustom ?? BorderRadius.circular(borderRadius ?? 0))
              : null,
          shape: shape ?? BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: fit ?? BoxFit.cover,
          ),
        ),
      ),
      fit: BoxFit.cover,
      alignment: alignment,
      memCacheHeight: Config.memCacheHeight,
      maxWidthDiskCache: Config.memCacheWidth,
      maxHeightDiskCache: Config.memCacheHeight,
      memCacheWidth: Config.memCacheWidth,
      placeholder: (context, url) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          alignment: Alignment.center,
          color: Colors.white,
        ),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          SizedBox(
            height: height,
            width: width,
            child: Center(child: Assets.svg.icImageDefault.svg()),
          ),
    );
  }
}

CachedNetworkImageProvider cachedNetworkImageProvider(url) =>
    CachedNetworkImageProvider(
      url,
    );

class CachedImageNoSizeWidget extends StatelessWidget {
  final String url;
  final Alignment alignment;
  final double? borderRadius;
  final BorderRadiusGeometry? borderRadiusCustom;
  final BoxShape? shape;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Widget? errorWidget;

  const CachedImageNoSizeWidget({
    Key? key,
    required this.url,
    this.borderRadius,
    this.borderRadiusCustom,
    this.alignment = Alignment.topLeft,
    this.fit,
    this.shape,
    this.width,
    this.height,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: shape == null
          ? (borderRadiusCustom ?? BorderRadius.circular(borderRadius ?? 0))
          : BorderRadius.zero,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: shape ?? BoxShape.rectangle,
        ),
        child: CachedNetworkImage(
          cacheKey: url,
          imageUrl: url,
          fit: fit ?? BoxFit.cover,
          alignment: alignment,
          memCacheHeight: Config.memCacheHeight,
          maxWidthDiskCache: Config.memCacheWidth,
          maxHeightDiskCache: Config.memCacheHeight,
          memCacheWidth: Config.memCacheWidth,
          placeholder: (context, url) => Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: height,
              width: width,
              alignment: Alignment.center,
              color: Colors.white,
            ),
          ),
          errorWidget: (context, url, error) =>
              errorWidget ??
              SizedBox(
                height: height,
                width: width,
                child: Center(child: Assets.svg.icImageDefault.svg()),
              ),
        ),
      ),
    );
  }
}
