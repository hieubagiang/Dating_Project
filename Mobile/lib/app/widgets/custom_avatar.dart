import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAvatar extends StatefulWidget {
  final String? fullName;
  final String? avatarUrl;
  final File? file;
  final String? asset;
  final Function()? onTap;
  final double? sizeAvatar;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? padding;
  final double? borderRadius;
  final bool? showCameraIcon;
  final bool? isCircleAvatar;

  CustomAvatar({
    Key? key,
    this.fullName = '',
    this.avatarUrl,
    this.file,
    this.asset,
    this.onTap,
    this.sizeAvatar,
    this.backgroundColor,
    this.borderColor,
    this.padding,
    this.borderRadius = 0,
    this.showCameraIcon = false,
    this.isCircleAvatar = true,
  }) : super(key: key);

  @override
  _CustomAvatarState createState() => _CustomAvatarState();
}

class _CustomAvatarState extends State<CustomAvatar> {
  String _getAvatarText() {
    return FunctionUtils.convertFullNameToAvatarText(widget.fullName);
  }

  @override
  Widget build(BuildContext context) {
    final newSizeAvatar = widget.sizeAvatar ?? 160.w;
    return InkWell(
      onTap: widget.onTap,
      child: Stack(children: [
        Container(
          height: newSizeAvatar,
          width: newSizeAvatar,
          decoration: BoxDecoration(
            border: Border.all(
              width: widget.padding ?? 0,
              color:
                  widget.borderColor ?? widget.backgroundColor ?? Colors.white,
            ),
            shape: BoxShape.circle,
          ),
          child: ClipRRect(
            borderRadius: (widget.isCircleAvatar ?? false)
                ? BorderRadius.circular(80.w)
                : BorderRadius.circular(widget.borderRadius ?? 0),
            child: _buildAvatarWidget(newSizeAvatar),
          ),
        ),
        (widget.showCameraIcon ?? false)
            ? Positioned(
                // bottom: SpaceUtils.spaceSmall,
                // right: SpaceUtils.spaceSmall,
                bottom: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(SpaceUtils.spaceSmall),
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorUtils.primaryColor,
                      border: Border.all(color: Colors.white, width: 2)),
                  child: SvgPicture.asset(
                    IconUtils.icCamera,
                    color: ColorUtils.secondaryColor,
                  ),
                ),
              )
            : const SizedBox()
      ]),
    );
  }

  Widget _buildAvatarWidget(num newSizeAvatar) {
    if (widget.file != null) {
      return Image.file(
        widget.file!,
        fit: BoxFit.cover,
      );
    }
    if (widget.avatarUrl != null && widget.avatarUrl!.isNotEmpty) {
      return CachedNetworkImage(
        cacheKey: widget.avatarUrl,
        imageUrl: widget.avatarUrl!,
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
            margin: EdgeInsets.all(SpaceUtils.spaceLarge),
            child: CircularProgressIndicator(
                value: downloadProgress.progress,
                color: ColorUtils.primaryColor)),
        fit: BoxFit.cover,
        errorWidget: (context, url, error) {
          return Icon(Icons.info);
        },
      );
    }

    if (widget.asset != null && widget.asset!.isNotEmpty) {
      return CachedNetworkImage(
        cacheKey: widget.asset,
        imageUrl: widget.asset!,
        fit: BoxFit.cover,
      );
    }
    return Container(
      color: _getAvatarText().isEmpty
          ? ColorUtils.greyColor
          : ColorUtils.primaryColor,
      height: SizeUtils.avatarSize,
      width: SizeUtils.avatarSize,
      child: Center(
        child: _getAvatarText().isEmpty
            ? Icon(
                Icons.person,
                size: SizeUtils.avatarSize,
                color: ColorUtils.primaryColor,
              )
            : Text(
                _getAvatarText(),
                style: StyleUtils.style16Normal
                    .copyWith(color: ColorUtils.secondaryColor),
              ),
      ),
    );
  }
}
