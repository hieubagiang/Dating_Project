import 'package:dating_app/app/common/utils/index.dart';
import 'package:flutter/material.dart';

class Consts {
  Consts._();

  static double padding = SpaceUtils.spaceMedium;
  static const double avatarRadius = 66.0;
}

class BaseDialog extends StatelessWidget {
/*  static Future<void> show(
      {required BuildContext context,
      required BaseDialog dialog,
      Function? afterClose}) async {
    await showDialog(
      barrierDismissible: false,
      //barrierColor: ColorUtils.blackColor.withOpacity(0.1),
      context: context,
      builder: (BuildContext context) => dialog,
    );
    if (afterClose != null) {
      afterClose();
    }
  }*/

  final BuildContext context;
  final Widget? titleWidget;
  final Widget? bodyWidget;
  final bool? showLoad;
  final List<Widget> actions;
  final double? width;

  BaseDialog({
    required this.titleWidget,
    this.showLoad,
    required this.actions,
    required this.bodyWidget,
    required this.context,
    this.width = 533,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Consts.padding),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: showLoad != null && showLoad!
          ? _buildLoading()
          : Container(
              width: width,
              padding: EdgeInsets.only(
                top: SpaceUtils.spaceMedium,
                bottom: Consts.padding,
                left: Consts.padding,
                right: Consts.padding,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(Consts.padding),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: titleWidget != null
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // To make the card compact
                children: <Widget>[
                  titleWidget ?? SizedBox()
                  /*title.isNotEmpty
                      ? Text(title,
                          textAlign: TextAlign.left,
                          style: StyleUtils.style16Normal
                              .copyWith(fontWeight: FontWeight.w600))
                      : SizedBox()*/
                  ,
                  SizedBox(height: SpaceUtils.spaceSmall),
                  bodyWidget ??
                      const SizedBox() /*??
                      Text(
                        description!,
                        textAlign: title.isNotEmpty
                            ? TextAlign.left
                            : TextAlign.center,
                        style: StyleUtils.style16Normal,
                      )*/
                  ,
                  if (actions.isNotEmpty)
                    SizedBox(height: SpaceUtils.spaceSmall),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: actions,
                  )
                ],
              ),
            ),
    );
  }

  Container _buildLoading() {
    return Container(
        padding: EdgeInsets.only(
          top: 20,
          bottom: Consts.padding,
          left: Consts.padding,
          right: Consts.padding,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(Consts.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              SizedBox(height: 10.0),
              CircularProgressIndicator(
                backgroundColor: Colors.white,
                valueColor:
                    AlwaysStoppedAnimation<Color>(ColorUtils.primaryColor),
              ),
              SizedBox(height: 10.0),
            ]));
  }

  Future<void> show({Function(dynamic)? afterClose}) async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => this,
    ).then((value) {
      afterClose?.call(value);
    });
  }
}
