import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/gender_enum.dart';
import 'package:dating_app/app/data/enums/hobby_enum.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/widgets/sign_up_interest.dart';
import 'package:dating_app/app/widgets/dialogs_widget/custom_cupertion_action_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'edit_controller.dart';

class EditScreen extends BaseView<EditController> {
  @override
  Widget vBuilder(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.arrow_back, color: ColorUtils.primaryColor2)),
        backgroundColor: ColorUtils.whiteColor,
        title: Text('edit'.tr, style: StyleUtils.style24Medium),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtils.whiteColor,
              elevation: 0,
              foregroundColor: ColorUtils.primaryColor,
              shadowColor: ColorUtils.lightPrimaryColor,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              controller.onSubmitted();
            },
            child: Text(
              'done'.tr,
              style: StyleUtils.style24Medium.copyWith(
                color: ColorUtils.primaryColor,
              ),
            ),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          controller.onSubmitted();
          FunctionUtils.showToast(
            'update_profile_successfully'.tr,
            backgroundColor: ColorUtils.primaryColor,
            textColor: ColorUtils.secondaryColor,
          );
        },
        child: SingleChildScrollView(
          child: Container(
            color: ColorUtils.blackColor.withOpacity(0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 8, horizontal: SpaceUtils.spaceSmall),
                  child: Text(
                    'select_your_photos'.tr,
                    style: StyleUtils.style20Medium,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
                  child: Obx(() {
                    return GridView.builder(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: controller.photoList.length,
                        padding: EdgeInsets.all(SpaceUtils.spaceSmall),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1 / 1.5,
                            crossAxisSpacing: SpaceUtils.spaceMedium,
                            mainAxisSpacing: SpaceUtils.spaceMedium),
                        itemBuilder: (context, index) {
                          return _addImageButton(index, size);
                        });
                  }),
                ),
                editInfo(
                    title: 'introduceYourself'.tr,
                    hintText: 'introduceYourself'.tr,
                    controller: controller.descriptionTextController),
                SizedBox(height: SpaceUtils.spaceSmall),
                GestureDetector(
                  onTap: _onSelectGender,
                  child: Obx(() {
                    return editInfo(
                      title: 'gender'.tr,
                      isEnabled: false,
                      hintText:
                          controller.currentUser.value?.gender?.label ?? '',
                    );
                  }),
                ),
                SizedBox(height: SpaceUtils.spaceSmall),
                GestureDetector(
                  onTap: () {
                    Get.dialog(SignUpHobby(
                      hobbyList: controller.hobbyList,
                      selectedList: controller.currentUser.value?.hobbies ?? [],
                      isDialog: true,
                      onTapHobby: controller.onTapHobby,
                    )).then((value) => {
                          FunctionUtils.showToast('Cập nhật hồ sơ thành công',
                              backgroundColor: ColorUtils.primaryColor,
                              textColor: ColorUtils.secondaryColor)
                        });
                  },
                  child: Obx(() {
                    return editInfo(
                      title: 'hobby'.tr,
                      isEnabled: false,
                      hintText: controller.currentUser.value!.hobbies
                              ?.map((e) => HobbyTypeEnum.getType(e.id)?.label)
                              .toList()
                              .join(", ") ??
                          'Chưa có sở thích',
                    );
                  }),
                ),
                SizedBox(height: SpaceUtils.spaceLarger),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImageAndCrop(int index) async {
    File? croppedFile = await FileUtils.getImageAndCrop();
    if (croppedFile != null) {
      controller.addImage(croppedFile, index, '${index + 1}');
    }
  }

  Widget _addImageButton(int position, Size size) {
    return GestureDetector(
      onTap: () {
        // _imagePosition = position
        _getImageAndCrop(position);
      },
      child: /*true
          ? AspectRatio(
              aspectRatio: 0.7,
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: controller.photoListUrl[position],
                placeholder: (context, url) => UnconstrainedBox(
                  child: SizedBox(
                      height: SpaceUtils.spaceLarge,
                      width: SpaceUtils.spaceLarge,
                      child: CircularProgressIndicator(
                        color: ColorUtils.primaryColor,
                      )),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
          :*/
          Obx(() {
        return Container(
            width: size.width * 0.2,
            height: size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: (position < controller.photoListUrl.length)
                  ? DecorationImage(
                      image: CachedNetworkImageProvider(
                          controller.photoListUrl[position]),
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
            child: (position < controller.photoListUrl.length)
                ? Container()
                : Icon(Icons.add_photo_alternate,
                    size: 70.sp, color: Colors.grey.withOpacity(0.3)));
      }),
    );
  }

  Widget editInfo(
      {String? title,
      String? hintText,
      TextEditingController? controller,
      bool isEnabled = true}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _builtTitle(title),
      Container(
        color: ColorUtils.whiteColor,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          enabled: isEnabled,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                  horizontal: SpaceUtils.spaceMedium,
                  vertical: SpaceUtils.spaceSmall),
              isDense: true,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedErrorBorder: InputBorder.none,
              hintText: '\t\t${hintText ?? ''}'),
        ),
      )
    ]);
  }

  Padding _builtTitle(String? title) {
    return Padding(
      padding: EdgeInsets.all(SpaceUtils.spaceSmall).copyWith(left: 16.w),
      child: Text(title ?? '', style: StyleUtils.style20Bold),
    );
  }

  void _onSelectGender() {
    final listAction = [
      Container(
        color: ColorUtils.whiteColor,
        padding: EdgeInsets.only(bottom: SpaceUtils.spaceSmall),
        child: CupertinoActionSheetAction(
          child: Text(
            GenderType.male.label,
            style: StyleUtils.style18Normal
                .copyWith(color: ColorUtils.primaryColor),
          ),
          onPressed: () {
            controller.onChangeGender(GenderType.male);
            Get.back();
          },
        ),
      ),
      Container(
        color: ColorUtils.lightGreyColor,
        width: double.infinity,
        height: 1,
      ),
      Container(
        color: ColorUtils.whiteColor,
        padding: EdgeInsets.only(bottom: SpaceUtils.spaceSmall),
        child: CupertinoActionSheetAction(
          child: Text(
            GenderType.female.label,
            style: StyleUtils.style18Normal
                .copyWith(color: ColorUtils.primaryColor),
          ),
          onPressed: () {
            controller.onChangeGender(GenderType.female);
            Get.back();
          },
        ),
      ),
    ];
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) => CustomBottomDialog(
              actions: listAction,
            ));
  }
}
