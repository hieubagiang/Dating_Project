import 'package:cached_network_image/cached_network_image.dart';
import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/user_model/hobby_model/hobby_model.dart';
import 'package:dating_app/app/presentation/pages/feed/const_data.dart';
import 'package:dating_app/app/widgets/appbar_widget/appbar_widget.dart';
import 'package:dating_app/app/widgets/photo_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'user_profile_controller.dart';

class UserProfileScreen extends BaseView<UserProfileController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        controller: controller.scrollController,
        physics: BouncingScrollPhysics(),
        child: Stack(
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight * 2,
            ),
            _buildMainImage(context),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              child: Stack(
                children: [
                  _buildInformation(context),
                  _buildInteractActionBar(),
                ],
              ),
            ),
            _buildAppBar()
          ],
        ),
      ),
    );
  }

  Widget _buildInformation(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().screenHeight * 0.05),
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: ColorUtils.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(BorderUtils.borderRadius),
          topRight: Radius.circular(BorderUtils.borderRadius),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: SpaceUtils.spaceMedium,
        vertical: SpaceUtils.spaceLarge * 1.5,
      ),
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTitle(
              '${controller.selectedUser.value.name}, ${controller.selectedUser.value.age}',
              style: StyleUtils.style24Medium,
            ),
            _buildBodyText(controller.selectedUser.value.job ?? ''),
            SizedBox(
              height: SpaceUtils.spaceMedium,
            ),
            _buildTitle('location'.tr),
            _buildBodyText(controller.address.value ?? ''),
            SizedBox(
              height: SpaceUtils.spaceMedium,
            ),
            _buildTitle('bio'.tr),
            _buildBodyText(controller.selectedUser.value.description ?? ''),
            SizedBox(
              height: SpaceUtils.spaceMedium,
            ),
            _buildTitle('hobbies'.tr),
            SizedBox(
              height: SpaceUtils.spaceSmall,
            ),
            _buildChips(controller.selectedUser.value.hobbies ?? []),
            SizedBox(
              height: SpaceUtils.spaceMedium,
            ),
            _buildTitle('photo'.tr),
            SizedBox(
              height: SpaceUtils.spaceMedium,
            ),
            GridView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: controller.selectedUser.value.photoList?.length ?? 0,
              padding: EdgeInsets.all(SpaceUtils.spaceSmall),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1 / 1,
                crossAxisSpacing: SpaceUtils.spaceMedium,
                mainAxisSpacing: SpaceUtils.spaceMedium,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext builder) => PhotoViewPage(
                        controller.selectedUser.value.photoList!
                            .map((e) => e.url)
                            .toList(),
                        index,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            controller.selectedUser.value.photoList![index].url,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            BorderRadius.circular(SpaceUtils.spaceSmall),
                      ),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: SpaceUtils.spaceMedium),
          ],
        );
      }),
    );
  }

  Text _buildBodyText(String text) {
    return Text(
      text,
      style: StyleUtils.style16Normal,
    );
  }

  Text _buildTitle(String text, {TextStyle? style}) {
    return Text(text, style: style ?? StyleUtils.style24Medium);
  }

  Widget _buildInteractActionBar() {
    return Container(
      width: ScreenUtil().screenWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Flexible(child: _buildInteractingActionBar())],
      ),
    );
  }

  Widget _buildInteractingActionBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: InteractTypeEnum.listExceptUndo
          .map(
            (element) => bottomButtonWidget(
              data: element.bottomButtonData,
              onPressed: () => controller.onTapInteractingActionButton(element),
            ),
          )
          .toList(),
    );
  }

  Widget _buildMainImage(BuildContext context) {
    return Obx(() {
      return Hero(
        tag: controller.heroTag,
        child: Container(
          height: MediaQuery.of(context).size.height / 1.9,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                controller.selectedUser.value.avatarUrl,
                cacheKey: 'avatar_${controller.selectedUser.value.id}',
              ),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      );
    });
  }

  Widget _buildAppBar() {
    return Positioned(
      top: SpaceUtils.spaceLarge,
      left: SpaceUtils.spaceLarge,
      child: SafeArea(
        child: AppBarButton(
          height: SizeUtils.iconSizeLarge,
          width: SizeUtils.iconSizeLarge,
          onTap: () {
            Get.back();
          },
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorUtils.primaryColor, width: 1.5),
            ),
            child: SvgPicture.asset(
              IconUtils.icBack,
              height: SizeUtils.iconSizeLarge,
              width: SizeUtils.iconSizeLarge,
              color: ColorUtils.primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChips(List<HobbyModel> hobbies) {
    List<Widget> chips = [];

    for (int i = 0; i < hobbies.length; i++) {
      chips.add(
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: SpaceUtils.spaceMedium,
            vertical: SpaceUtils.spaceSmall,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: ColorUtils.primaryColor),
            borderRadius: BorderRadius.circular(SpaceUtils.spaceSmall),
          ),
          child: Text(
            ('hobbies.' + hobbies[i].name).tr,
            style: StyleUtils.style14Normal
                .copyWith(color: ColorUtils.primaryColor),
          ),
        ),
      );
    }

    return SizedBox(
      width: ScreenUtil().screenWidth - SpaceUtils.spaceMedium * 2,
      child: Wrap(
        spacing: SpaceUtils.spaceSmall,
        runSpacing: SpaceUtils.spaceSmall,
        children: chips,
      ),
    );
  }

  Widget bottomButtonWidget({
    required BottomButtonData data,
    Function()? onPressed,
  }) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: SpaceUtils.spaceSmall),
        // decoration: BoxDecoration(boxShadow: [ShadowUtils.boxShadow]),
        child: RawMaterialButton(
          onPressed: onPressed,
          child: FaIcon(
            data.iconData,
            color: data.iconColor,
            size: (data.iconData == FontAwesomeIcons.solidHeart)
                ? SizeUtils.iconSizeLarge
                : SizeUtils.iconSize,
          ),
          shape: CircleBorder(),
          elevation: 15,
          fillColor: Colors.white,
          padding: const EdgeInsets.all(14.0),
        ),
      ),
    );
  }
}
