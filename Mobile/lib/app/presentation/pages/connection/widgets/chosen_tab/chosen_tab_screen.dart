import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/data/enums/ads_premium_enum.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/ads_premium.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/profile_card.dart';
import 'package:dating_app/app/widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';

import 'chosen_tab_controller.dart';

class ChosenTabScreen extends BaseView<ChosenTabController> {
  final MatchesController _controller = Get.find();

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          !(_controller.currentUser.value?.isPremiumUser ?? false)
              ? Expanded(
                  child: AdsPremium(
                  type: AdsPremiumType.chosen,
                ))
              : Obx(() {
                  return Expanded(
                    child: (controller.chosenUserList.value.isEmpty)
                        ? EmptyDataWidget()
                        : SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    controller.chosenUserList.value.length,
                                padding: EdgeInsets.all(SpaceUtils.spaceSmall),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7,
                                        crossAxisSpacing: SpaceUtils.spaceSmall,
                                        mainAxisSpacing: SpaceUtils.spaceSmall),
                                itemBuilder: (context, index) {
                                  var model =
                                      controller.chosenUserList.value[index];
                                  var heroTag =
                                      '${runtimeType}_user_profile_card_${model.currentUser.id}';

                                  return ProfileCard(
                                    name: model.currentUser.name,
                                    age: model.currentUser.age,
                                    heroTag: heroTag,
                                    width: Get.width / 2,
                                    imageUrl: model.currentUser.avatarUrl,
                                    onTap: () {
                                      controller.onTapCard(
                                          model.currentUserId, heroTag);
                                    },
                                    onTapDislike: () {
                                      controller.interact(
                                          model, InteractType.dislike);
                                    },
                                    onTapLike: () {
                                      controller.interact(
                                          model, InteractType.like);
                                    },
                                    id: model.currentUserId,
                                  );
                                }),
                          ),
                  );
                }),
        ],
      ),
    );
  }
}
