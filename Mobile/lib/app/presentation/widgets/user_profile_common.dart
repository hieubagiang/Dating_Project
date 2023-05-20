import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/presentation/pages/feed/const_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

mixin userProfileCommon {
  Widget userInformation(UserModel userData, Size size) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 2),
                child: Text(
                  userData.name ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 36,
                      shadows: [
                        Shadow(
                            blurRadius: 1.0,
                            color: Colors.black,
                            offset: Offset(0.6, 0.6))
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  '${DateTime.now().difference(userData.birthday!).inDays ~/ 365}',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                      shadows: [
                        Shadow(
                            blurRadius: 1.0,
                            color: Colors.black,
                            offset: Offset(0.6, 0.6))
                      ]),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 12),
            child: Container(
              width: size.width - 20,
              child: Text(
                userData.description!,
                softWrap: true,
                style: TextStyle(fontSize: 22, color: Colors.white, shadows: [
                  Shadow(
                      blurRadius: 1.0,
                      color: Colors.black,
                      offset: Offset(0.6, 0.6))
                ]),
              ),
            ),
          ),
          Wrap(
            children: userData.hobbies!.map((e) {
              return interestingWidget(e.name);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget interestingWidget(String interesting) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 4.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.grey[700]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
          child: Text(
            interesting,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget bottomButtonWidget({
    required BottomButtonData data,
    Function()? undo,
    Function()? dislike,
    Function()? like,
    Function()? superLike,
    Function()? boost,
  }) {
    return Flexible(
      child: RawMaterialButton(
        onPressed: () {
          if (data.iconData == FontAwesomeIcons.redoAlt) {
            undo?.call();
          } else if (data.iconData == FontAwesomeIcons.times) {
            dislike?.call();
            //cardController.triggerLeft();
          } else if (data.iconData == FontAwesomeIcons.solidHeart) {
            // cardController.triggerRight();
            like?.call();
          } else if (data.iconData == FontAwesomeIcons.comments) {
            // cardController.triggerUp();
            superLike?.call();
          } else if (data.iconData == FontAwesomeIcons.bolt) {
            // cardController.triggerUp();
            boost?.call();
          }
        },
        child: FaIcon(
          data.iconData,
          color: data.iconColor,
          size: (data.iconData == FontAwesomeIcons.times ||
                  data.iconData == FontAwesomeIcons.solidHeart)
              ? 32.0
              : 20,
        ),
        shape: CircleBorder(),
        elevation: 1.0,
        fillColor: Colors.white,
        padding: EdgeInsets.all(13.h),
      ),
    );
  }
}
