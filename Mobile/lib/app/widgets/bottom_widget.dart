import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomWidget extends StatelessWidget {
  final Function() onClickChat;
  final Function() onClickMemo;

  const BottomWidget({
    Key? key,
    required this.notificationNumber,
    required this.onClickChat,
    required this.onClickMemo,
  }) : super(key: key);

  final int notificationNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: SpaceUtils.spaceLarge,
          right: SpaceUtils.spaceLarge,
          bottom: HeightUtils.heightMedium,
          top: HeightUtils.heightExtraLarge),
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(
                  color: ColorUtils.darkGreyColor,
                  width: HeightUtils.heightLineMedium))),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: HeightUtils.heightButtonMedium,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _button('chat'.tr, onClickChat),
                    Transform.translate(
                        offset: Offset(
                            // -HeightUtils.heightButtonMedium,
                            //   -WidthUtils.widthSmall
                            -BorderUtils.borderButtonLarge * 0.5,
                            -HeightUtils.heightButtonMedium * 0.5),
                        child: Container(
                            width: BorderUtils.borderButtonLarge,
                            height: BorderUtils.borderButtonLarge,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Text(notificationNumber.toString(),
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)),
                            )))
                  ],
                )),
            SizedBox(
              width: SpaceUtils.spaceMedium,
              child: Container(),
            ),
            _button('memo'.tr, onClickMemo)
          ],
        ),
      ),
    );
  }

  Widget _button(String name, Function onClick) {
    return GestureDetector(
        onTap: () {
          onClick();
        },
        child: Center(
            child: Container(
                height: HeightUtils.heightButtonMedium,
                padding:
                    EdgeInsets.symmetric(horizontal: SpaceUtils.spaceLarge),
                decoration: BoxDecoration(
                    color: ColorUtils.greyColor,
                    border: Border.all(color: Colors.black)),
                child: Center(child: Text(name)))));
  }
}
