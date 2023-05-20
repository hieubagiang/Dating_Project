import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/layout_utils.dart';
import 'package:dating_app/app/data/enums/ads_premium_enum.dart';
import 'package:dating_app/app/presentation/pages/connection/connection_controller.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/ads_premium.dart';
import 'package:dating_app/app/presentation/pages/connection/widgets/profile_card.dart';
import 'package:dating_app/app/widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';

import 'liked_tab_controller.dart';

class LikedTabScreen extends BaseView<LikedTabController> {
  final MatchesController _controller = Get.find();

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          !(_controller.currentUser.value?.isPremiumUser ?? false)
              ? Expanded(
                  child: AdsPremium(
                  type: AdsPremiumType.like,
                ))
              : Obx(() {
                  return Expanded(
                    child: (controller.likedUserList.value.isEmpty)
                        ? EmptyDataWidget()
                        : SingleChildScrollView(
                            controller: controller.scrollController,
                            physics: BouncingScrollPhysics(),
                            child: GridView.builder(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    controller.likedUserList.value.length,
                                padding: EdgeInsets.all(SpaceUtils.spaceSmall),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 0.7,
                                        crossAxisSpacing: SpaceUtils.spaceSmall,
                                        mainAxisSpacing: SpaceUtils.spaceSmall),
                                itemBuilder: (context, index) {
                                  var model =
                                      controller.likedUserList.value[index];
                                  var heroTag =
                                      '${runtimeType}_user_profile_card_${model.interactedUserId}';

                                  return ProfileCard(
                                    name: model.interactedUser.name,
                                    age: model.interactedUser.age,
                                    width: Get.width / 2,
                                    heroTag: heroTag,
                                    imageUrl: model.interactedUser.avatarUrl,
                                    onTap: () {
                                      controller.onTapCard(model, heroTag);
                                    },
                                    onTapDislike: () {
                                      controller.dislike(model);
                                    },
                                    id: model.interactedUserId,
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
