import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoListWidget extends StatefulWidget {
  final List<String> imageUrls;
  final Function(int) onImageClicked;

  const PhotoListWidget({
    Key? key,
    required this.imageUrls,
    required this.onImageClicked,
  }) : super(key: key);

  @override
  _PhotoListWidgetState createState() => _PhotoListWidgetState();
}

class _PhotoListWidgetState extends State<PhotoListWidget> {
  @override
  Widget build(BuildContext context) {
    return widget.imageUrls.isNotEmpty
        ? ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: _buildImageWidgetList(),
          )
        : const SizedBox();
  }

  List<Widget> _buildImageWidgetList() {
    if (widget.imageUrls.length <= 4) {
      return widget.imageUrls
          .asMap()
          .map((key, value) => MapEntry(key, _buildImageWidget(value, key)))
          .values
          .toList();
    }
    final widgets = <Widget>[];
    //if imageList.length>4 then show 3 normal image, fourth image with remaining image counter
    for (var i = 0; i < widget.imageUrls.length; i++) {
      if (i > 3) {
        break;
      }
      if (i == 3) {
        widgets.add(_buildImageWithRemainingWidget(
            widget.imageUrls[i], widget.imageUrls.length - 3, i));
        break;
      } else {
        widgets.add(_buildImageWidget(widget.imageUrls[i], i));
      }
    }
    return widgets;
  }

  Widget _buildImageWidget(String imageUrl, int index) {
    return InkWell(
      onTap: () {
        widget.onImageClicked.call(index);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: index < 3 ? SpaceUtils.spaceSmall : 0),
        child: Hero(
          tag: imageUrl,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(SpaceUtils.spaceSmall),
            child: AspectRatio(
              aspectRatio: 2.84,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: imageUrl,
                placeholder: (context, url) =>
                    CupertinoActivityIndicator(radius: SpaceUtils.spaceSmall),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //build fourth image stack overlay with +remaining image in list
  Widget _buildImageWithRemainingWidget(
      String imageUrl, int remaining, int index) {
    return Container(
      height: HeightUtils.heightImage,
      child: Stack(fit: StackFit.expand, children: [
        _buildImageWidget(imageUrl, index),
        InkWell(
          onTap: () => widget.onImageClicked.call(index),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.black54,
                borderRadius: BorderRadius.circular(SpaceUtils.spaceSmall)),
            child: Text(
              '+$remaining',
              style: TextStyle(color: ColorUtils.whiteColor),
            ),
          ),
        )
      ]),
    );
  }
}
