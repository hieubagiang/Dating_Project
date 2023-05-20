import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/sign_up_controller.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/widgets/sign_up_form.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/widgets/sign_up_image.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/widgets/sign_up_interest.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/widgets/sign_up_introduce.dart';
import 'package:dating_app/app/presentation/pages/authentication/sign_up/widgets/sign_up_sex.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpMain extends StatefulWidget {
  @override
  _SignUpMainState createState() => _SignUpMainState();
}

class _SignUpMainState extends State<SignUpMain> {
  final PageController _pageController = PageController();
  int _currentPageViewIndex = 0;
  Color? _nextColor = ColorUtils.logoThirdColor;
  String _nextButtonString = 'next'.tr;
  final _signUpController = Get.put(SignUpController());

  void changeNextButtonTextAndColor(int page) {
    // _currentPageViewIndex = page.toDouble();
    switch (page) {
      case 4:
        _nextButtonString = 'startApp'.tr;
        _nextColor = ColorUtils.primaryColor2;
        break;
      default:
        _nextButtonString = 'next'.tr;
        _nextColor = ColorUtils.logoThirdColor;
        break;
    }
  }

  void cancelButtonEvent(context) => _currentPageViewIndex > 0
      ? _pageController.animateToPage(0,
          duration: Duration(milliseconds: 200), curve: Curves.easeIn)
      : Navigator.pop(context);

  void _moveToNextPage() {
    _currentPageViewIndex += 1;
    _pageController.animateToPage(_currentPageViewIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void _moveToPreviousPage() {
    _currentPageViewIndex -= 1;
    _pageController.animateToPage(_currentPageViewIndex,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  void nextButtonEvent() {
    _pageController.page?.toInt() == 4
        ? _signUpController.submitSignUp()
        : _moveToNextPage();
  }

  Widget _pageViewIndicator(int location) {
    return Expanded(
      child: Divider(
        height: 1,
        thickness: 3,
        color: location - 1 <= _currentPageViewIndex &&
                _currentPageViewIndex < location
            ? ColorUtils.primaryColor.withOpacity(0.7)
            : ColorUtils.primaryColor.withOpacity(0.3),
        indent: 6.0,
      ),
    );
  }

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPageViewIndex = _currentPageViewIndex;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Container(
          decoration: BoxDecoration(color: ColorUtils.secondaryColor),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  children: [
                    _pageViewIndicator(1),
                    _pageViewIndicator(2),
                    _pageViewIndicator(3),
                    _pageViewIndicator(4),
                    _pageViewIndicator(5),
                  ],
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) =>
                        setState(() => changeNextButtonTextAndColor(page)),
                    children: [
                      SignUpForm(),
                      SignUpIntroduce(),
                      SignUpSex(),
                      SignUpImages(),
                      SignUpHobby(
                        hobbyList: _signUpController.hobbies,
                        onTapHobby: (model, isSelected) {
                          _signUpController.onTapInterest(
                              model: model, isSelected: isSelected);
                        },
                        selectedList: [],
                      )
                    ],
                  ),
                  if (_currentPageViewIndex != 0)
                    Positioned(
                      top: 0.h,
                      left: 16.w,
                      child: IconButton(
                        icon: SvgPicture.asset(
                          IconUtils.icBack,
                          color: ColorUtils.primaryColor,
                          height: SizeUtils.iconSizeLarge,
                          width: SizeUtils.iconSizeLarge,
                        ),
                        onPressed: () {
                          _moveToPreviousPage();
                        },
                      ),
                    )
                ],
              )),
              Row(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(() {
                      return ButtonWidget(
                        onPress: () {
                          if (_requiredValidData()) {
                            print(_currentPageViewIndex);
                            nextButtonEvent();
                          }
                          if (_signUpController.isAgreeTerm.isFalse) {
                            FunctionUtils.showSnackBar(
                                'attention'.tr, 'continue-signup'.tr,
                                backgroundColor: ColorUtils.primaryColor2,
                                colorText: Colors.white);
                          }
                          if (_signUpController.avatarUrl.isEmpty) {
                            FunctionUtils.showSnackBar(
                                'attention'.tr, 'continue-upload-image'.tr,
                                backgroundColor: ColorUtils.primaryColor2,
                                colorText: Colors.white);
                          }
                        },
                        color: !_requiredValidData()
                            ? ColorUtils.greyColor
                            : _nextColor,
                        labelColor: _nextColor == ColorUtils.logoThirdColor
                            ? ColorUtils.whiteColor
                            : ColorUtils.secondaryColor,
                        label: _nextButtonString,
                      );
                    }),
                  ))
                ],
              )
            ],
          ),
        )));
  }

  bool _requiredValidData() {
    return _signUpController.isAgreeTerm.isTrue &&
        _signUpController.avatarUrl.isNotEmpty &&
        _signUpController.birthDate.value != null;
  }
}
