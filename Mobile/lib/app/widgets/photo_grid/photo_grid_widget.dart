import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PhotoGridWidget extends StatefulWidget {
  final List<String> imageUrls;
  final Function(int) onImageClicked;

  const PhotoGridWidget({
    Key? key,
    required this.imageUrls,
    required this.onImageClicked,
  }) : super(key: key);

  @override
  _PhotoGridWidgetState createState() => _PhotoGridWidgetState();
}

class _PhotoGridWidgetState extends State<PhotoGridWidget> {
  List<StaggeredTile> _buildStaggeredTile() {
    final imageTotal = widget.imageUrls.length;

    if (imageTotal == 1) {
      return [const StaggeredTile.count(4, 2)];
    } else if (imageTotal == 2) {
      return [const StaggeredTile.count(2, 2), const StaggeredTile.count(2, 2)];
    } else if (imageTotal == 3) {
      return [
        const StaggeredTile.count(2, 2),
        const StaggeredTile.count(2, 1),
        const StaggeredTile.count(2, 1),
      ];
    }
    return [
      const StaggeredTile.count(2, 1),
      const StaggeredTile.count(2, 1),
      const StaggeredTile.count(2, 1),
      const StaggeredTile.count(2, 1),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return widget.imageUrls.isNotEmpty
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: StaggeredGridView.count(
              crossAxisCount: 4,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              staggeredTiles: _buildStaggeredTile(),
              children: _buildImageWidgetList(),
            ),
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

  Widget _buildImageWidget(String url, int index) {
    return InkWell(
      onTap: () {
        widget.onImageClicked.call(index);
      },
      child: Hero(
        tag: url,
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: url,
          placeholder: (context, url) => CupertinoActivityIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
          cacheKey: url,
        ),
      ),
    );
  }

  //build fourth image stack overlay with +remaining image in list
  Widget _buildImageWithRemainingWidget(String url, int remaining, int index) {
    return Stack(fit: StackFit.expand, children: [
      _buildImageWidget(url, index),
      InkWell(
        onTap: () => widget.onImageClicked.call(index),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              shape: BoxShape.rectangle, color: Colors.black54),
          child: Text(
            '+$remaining',
            style: TextStyle(color: Colors.white),
          ),
        ),
      )
    ]);
  }
}
