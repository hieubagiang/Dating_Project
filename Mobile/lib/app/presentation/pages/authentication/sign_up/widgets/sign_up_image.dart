import 'dart:io';

import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpImages extends StatefulWidget {
  @override
  _SignUpImagesState createState() => _SignUpImagesState();
}

class _SignUpImagesState extends State<SignUpImages>
    with AutomaticKeepAliveClientMixin<SignUpImages> {
  @override
  bool get wantKeepAlive => true;

  int _imagePosition = 0;
  final List<File> _photoList = List<File>.generate(4, (file) => File(''));
  final SignUpController _controller = Get.find<SignUpController>();

  Widget _addImageButton(int position, Size size) {
    return GestureDetector(
      onTap: () {
        _imagePosition = position;
        _getImageAndCrop();
      },
      child: Container(
          width: size.width * 0.4,
          height: size.width * 0.6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            image: (_photoList[position].path != '')
                ? DecorationImage(
                    image: FileImage(_photoList[position]),
                    fit: BoxFit.fill,
                  )
                : null,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.6),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(1, 1), // changes position of shadow
              ),
            ],
          ),
          child: (_photoList[position].path != '')
              ? Container()
              : Icon(Icons.add_photo_alternate,
                  size: 130.h,
                  color: ColorUtils.primaryColor.withOpacity(0.7))),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SizedBox(height: 40.h),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: 24.w, vertical: SpaceUtils.spaceSmall),
            child: Text(
              'select_your_photos'.tr,
              style: TextStyle(
                  color: ColorUtils.primaryColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _addImageButton(0, size),
                  SizedBox(width: 16.w),
                  _addImageButton(1, size),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _addImageButton(2, size),
              SizedBox(width: 16.w),
              _addImageButton(3, size),
            ],
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  Future<void> _getImageAndCrop() async {
    File? croppedFile = await FileUtils.getImageAndCrop();
    if (croppedFile != null) {
      setState(() => _photoList[_imagePosition] = croppedFile);
      _controller.addImage(croppedFile, '${_imagePosition + 1}');
    }
  }
}
