import 'package:dating_app/app/common/base/base_view_view_model.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/widgets/empty_data_widget.dart';
import 'package:flutter/material.dart';

import '../../../main/main_controller.dart';
import '../profile_card.dart';
import 'top_picks_tab_controller.dart';

class TopPicksTabScreen extends BaseView<TopPicksTabController> {
  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            return Expanded(
              child: (controller.topPickUserList.value.isEmpty)
                  ? EmptyDataWidget()
                  : SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: GridView.builder(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: controller.topPickUserList.value.length,
                          padding: EdgeInsets.all(SpaceUtils.spaceSmall),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.7,
                                  crossAxisSpacing: SpaceUtils.spaceSmall,
                                  mainAxisSpacing: SpaceUtils.spaceSmall),
                          itemBuilder: (context, index) {
                            var model = controller.topPickUserList.value[index];
                            var heroTag =
                                '${runtimeType}_user_profile_card_${model.id}';

                            return ProfileCard(
                              name: model.name ?? '',
                              age: model.age,
                              width: Get.width / 2,
                              heroTag: heroTag,
                              imageUrl: model.avatarUrl,
                              onTap: () {
                                controller.onTapCard(model, heroTag);
                              },
                              onTapDislike: () {
                                controller.interact(
                                    model, InteractType.dislike);
                              },
                              onTapLike: () {
                                controller.interact(model, InteractType.like);
                              },
                              id: model.id ?? '',
                              isMe: model.id ==
                                  Get.find<MainController>()
                                      .currentUser
                                      .value!
                                      .id,
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
