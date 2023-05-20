import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/colors_utils.dart';
import 'package:dating_app/app/common/utils/icon_utils.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/common/utils/styles.dart';
import 'package:dating_app/app/data/models/user_model/hobby_model/hobby_model.dart';
import 'package:dating_app/app/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpHobby extends StatefulWidget {
  final Function(HobbyModel, bool)? onTapHobby;
  final List<HobbyModel> hobbyList;
  final List<HobbyModel> selectedList;
  final bool isDialog;

  const SignUpHobby(
      {Key? key,
      this.onTapHobby,
      required this.hobbyList,
      required this.selectedList,
      this.isDialog = false})
      : super(key: key);

  @override
  _SignUpHobbyState createState() => _SignUpHobbyState();
}

class _SignUpHobbyState extends State<SignUpHobby>
    with AutomaticKeepAliveClientMixin<SignUpHobby> {
  @override
  bool get wantKeepAlive => true;

  final List<HobbyModel> _selectedList = [];
  final List _iconInterestList = [];

  @override
  void initState() {
    super.initState();
    _selectedList.addAll(widget.selectedList);
    _iconInterestList.add(IconUtils.icCamera);
    _iconInterestList.add(IconUtils.icMarket);
    _iconInterestList.add(IconUtils.icVoice);
    _iconInterestList.add(IconUtils.icYoga);
    _iconInterestList.add(IconUtils.icNoodles);
    _iconInterestList.add(IconUtils.icTennis);
    _iconInterestList.add(IconUtils.icSport);
    _iconInterestList.add(IconUtils.icSwim);
    _iconInterestList.add(IconUtils.icPlatte);
    _iconInterestList.add(IconUtils.icOutdoor);
    _iconInterestList.add(IconUtils.icParachute);
    _iconInterestList.add(IconUtils.icMusic);
    _iconInterestList.add(IconUtils.icGoblet);
    _iconInterestList.add(IconUtils.icGame);
  }

  Widget _buildChips(
    List<HobbyModel> hobbies,
  ) {
    List<Widget> chips = [];

    for (int i = 0; i < hobbies.length; i++) {
      bool _selected = isSelected(hobbies[i]);
      ChoiceChip choiceChip = ChoiceChip(
        selected: _selected,
        //_selectedIndex == i,
        label: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Text(hobbies[i].label ?? 'null',
                  style: StyleUtils.style18Normal.copyWith(
                      color: _selected
                          ? ColorUtils.secondaryColor
                          : ColorUtils.primaryTextColor),
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
        padding: EdgeInsets.only(
          top: SpaceUtils.spaceSmall,
          bottom: SpaceUtils.spaceSmall,
          left: SpaceUtils.spaceMedium,
        ),
        avatar: i < _iconInterestList.length
            ? SvgPicture.asset(_iconInterestList[i],
                color: _selected
                    ? ColorUtils.whiteColor
                    : ColorUtils.primaryColor2)
            : Icon(Icons.add),
        elevation: 4,
        pressElevation: 3,
        shadowColor: Colors.grey,
        backgroundColor: ColorUtils.secondaryColor,
        selectedColor: ColorUtils.primaryColor,
        onSelected: (bool selected) {
          if (selected) {
            _selectedList.add(hobbies[i]);
          } else {
            _selectedList.remove(hobbies[i]);
          }
          setState(() {});

          widget.onTapHobby?.call(hobbies[i], selected);
          // controller.onTapInterest(model: hobbies[i], isSelected: selected);
        },
      );

      chips.add(Container(child: choiceChip));
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      childAspectRatio: 6 / 2,
      crossAxisSpacing: SpaceUtils.spaceSmall,
      children: chips,
    );
  }

  bool isSelected(HobbyModel model) => _selectedList.contains(model);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: (widget.isDialog)
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: SpaceUtils.spaceMedium,
                  vertical: SpaceUtils.spaceMedium),
              child: ButtonWidget(
                height: HeightUtils.heightButtonSmall,
                label: 'OK',
                onPress: () {
                  Get.back();
                },
              ),
            )
          : null,
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: SpaceUtils.spaceSmall, vertical: SpaceUtils.spaceLarge),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,

            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'select_your_interesting_fields'.tr,
                  style: TextStyle(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.bold,
                    color: ColorUtils.primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text('interest_decription'.tr,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.visible),
              ),
              Padding(
                padding: EdgeInsets.all(12.w),
                child: Obx(() {
                  return Container(child: _buildChips(widget.hobbyList));
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
