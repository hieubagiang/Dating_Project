import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageViewerDialog extends StatefulWidget {
  final List<Image> images;
  final int selectedIndex;
  const ImageViewerDialog({
    required this.images,
    this.selectedIndex = 0,
    Key? key,
  })  : assert(images.length > 0),
        super(key: key);

  @override
  _ImageViewerDialogState createState() => _ImageViewerDialogState();
}

class _ImageViewerDialogState extends State<ImageViewerDialog> {
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SvgPicture.asset(
                    'assets/svg/close.svg',
                  ),
                ),
              ],
            ),
            SizedBox(height: 32.0),
            Expanded(
              child: widget.images[_selectedIndex],
            ),
            SizedBox(height: 32.0),
            Row(
              children: [
                ...widget.images
                    .map(
                      (img) => Container(
                        width: 80.0,
                        height: 80.0,
                        margin: EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          border: widget.images.indexOf(img) == _selectedIndex
                              ? Border.all(color: ColorUtils.primaryColor)
                              : null,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16.0),
                          onTap: () {
                            setState(() {
                              _selectedIndex = widget.images.indexOf(img);
                            });
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: img,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
