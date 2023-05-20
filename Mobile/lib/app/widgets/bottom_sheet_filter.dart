import 'package:dating_app/app/presentation/pages/settings/setting_controller.dart';
import 'package:dating_app/app/widgets/dialogs_widget/custom_cupertion_action_sheet_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common/utils/index.dart';
import '../data/enums/interested_gender_enum.dart';
import '../presentation/pages/feed/controller/feed_controller.dart';

class BottomSheetFilter extends StatelessWidget {
  BottomSheetFilter({Key? key}) : super(key: key);
  final SettingsController _settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildContainerLarge(
            body: Padding(
          padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('max_space'.tr,
                    style: TextStyle(
                        fontSize: 18.sp, color: ColorUtils.primaryColor2)),
                Obx(() {
                  return Text('${_settingsController.distance.value.toInt()}km',
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: ColorUtils.blackColor.withOpacity(0.5)));
                }),
              ]),
              Obx(() {
                return Slider(
                  min: 0.0,
                  max: 1000.0,
                  activeColor: ColorUtils.primaryColor2,
                  inactiveColor: ColorUtils.lightPrimaryColor,
                  value: _settingsController.distance.value,
                  onChanged: (value) {
                    _settingsController.distance.value = value;
                  },
                );
              })
            ],
          ),
        )),
        SizedBox(height: SpaceUtils.spaceMedium),
        GestureDetector(
          onTap: _onSelectGender,
          child: _buildContainerSmall(
              widget: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('show_me'.tr,
                            style: TextStyle(
                                fontSize: 18,
                                color: ColorUtils.blackColor.withOpacity(0.5))),
                        Row(
                          children: [
                            Obx(() {
                              return Text(
                                  InterestedGenderTypeEnum.getType(
                                              Get.find<FeedController>()
                                                  .currentUser
                                                  .value
                                                  ?.feedFilter
                                                  ?.interestedInGender)
                                          ?.label ??
                                      '',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: ColorUtils.blackColor
                                          .withOpacity(0.5)));
                            }),
                            SizedBox(width: SpaceUtils.spaceSmall),
                            Icon(Icons.edit_outlined,
                                size: 18,
                                color: ColorUtils.blackColor.withOpacity(0.5))
                          ],
                        ),
                      ]))),
        ),
        SizedBox(height: SpaceUtils.spaceMedium),
        Obx(() {
          return _buildContainerLarge(
              body: Padding(
            padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
            child: Column(
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('age'.tr,
                          style: TextStyle(
                              fontSize: 18.sp,
                              color: ColorUtils.primaryColor2)),
                      Obx(() {
                        return Text(
                            '${_settingsController.rangeValues.value.start.toInt()} - ${_settingsController.rangeValues.value.end.toInt()}',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: ColorUtils.blackColor.withOpacity(0.5)));
                      }),
                    ]),
                RangeSlider(
                  min: 14,
                  max: 100,
                  activeColor: ColorUtils.primaryColor2,
                  inactiveColor: ColorUtils.lightPrimaryColor,
                  values: _settingsController.rangeValues.value,
                  onChanged: (values) {
                    _settingsController.rangeValues.value = values;
                  },
                )
              ],
            ),
          ));
        })
      ],
    );
  }

  Widget _buildContainerLarge(
      {String? title, Widget? body, String? description}) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title != null
              ? Padding(
                  padding: EdgeInsets.only(bottom: SpaceUtils.spaceSmall),
                  child: Text(title, style: StyleUtils.style20Bold),
                )
              : Container(),
          _buildContainerSmall(widget: body),
          description != null
              ? Padding(
                  padding: EdgeInsets.only(top: SpaceUtils.spaceSmall),
                  child: Text(
                    description,
                    style: StyleUtils.style16Normal,
                    overflow: TextOverflow.visible,
                  ))
              : Container()
        ]);
  }

  Widget _buildContainerSmall({Widget? widget}) {
    return Container(
        decoration: BoxDecoration(
          color: ColorUtils.whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black.withOpacity(0.2)),
          boxShadow: [ShadowUtils.bottomThinShadow, ShadowUtils.topThinShadow],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: SpaceUtils.spaceSmall),
          child: widget,
        ));
  }

  void _onSelectGender() {
    final actions = InterestedGenderTypeEnum.list
        .map((e) => Container(
              color: ColorUtils.whiteColor,
              child: CupertinoActionSheetAction(
                child: Text(
                  e.label,
                  style: StyleUtils.style18Normal,
                ),
                onPressed: () {
                  _settingsController.onChangeGender(e);
                  Get.back();
                },
              ),
            ))
        .toList();
    showCupertinoModalPopup(
        context: Get.context!,
        builder: (BuildContext context) => CustomBottomDialog(
              actions: actions,
            ));
  }
}
