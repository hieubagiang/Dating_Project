import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:dating_app/app/data/enums/interact_type.dart';
import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/get_recommendation_response.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/models/notification/notification_payload.dart';
import 'package:dating_app/app/data/provider/chat/chat_api.dart';
import 'package:dating_app/app/data/provider/feed_api.dart';
import 'package:dating_app/app/data/provider/recommendation_api.dart';
import 'package:dating_app/app/data/provider/user_api.dart';
import 'package:dating_app/app/data/request/push_notification/notification_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../enums/notification_type.dart';
import '../models/pagination.dart';
import '../provider/notification_api.dart';
import '../request/push_notification/send_notification_request.dart';

abstract class _FeedRepository {
  Future<GetRecommendationResponse?> getRecommendation(
      {required Pagination pagination});

  Future<void> interactUser({required InteractedUserModel interactedUserModel});

  Future<void> boost();
}

class FeedRepository extends _FeedRepository {
  final FeedApi _api = Get.find<FeedApi>();
  final UserApi _userApi = Get.find<UserApi>();
  final ChatApi _chatApi = Get.find<ChatApiImpl>();
  final _pushNotificationApi = Get.find<NotificationApi>();
  final RecommendationApi _recommendationApi = Get.find<RecommendationApi>();

  @override
  Future<GetRecommendationResponse?> getRecommendation({
    required Pagination pagination,
    bool isReload = false,
  }) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final result = await _recommendationApi.getRecommendation(
        bearerToken: token ?? '',
        request: pagination.toJson()..removeNulls(),
      );
      return result;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }

  @override
  Future<void> interactUser({
    required InteractedUserModel interactedUserModel,
  }) async {
    await _api.interactUser(interactedUserModel: interactedUserModel);
    final isMatched = await _isMatched(interactedUserModel);
    if (isMatched) {
      final channelModel = await _chatApi.createChannel(
          currentUser: interactedUserModel.currentUser.toMemberModel(),
          selectedUser: interactedUserModel.interactedUser.toMemberModel());
      _notiMatched(channelModel);
    }
  }

  Future<bool> _isMatched(InteractedUserModel interactedUserModel) async {
    bool isMatched = false;
    if (interactedUserModel.interactedType == InteractType.like.id) {
      isMatched = await _api.isMatchUser(
          userName1: interactedUserModel.interactedUserId,
          userName2: interactedUserModel.currentUserId);
    }
    return isMatched;
  }

  @override
  Future<void> boost() async {
//return await _api.interactUser(interactedUserModel: interactedUserModel);
  }

  Future<void> _notiMatched(ChannelModel channelModel) async {
    for (var member in channelModel.members!) {
      var anotherMember = channelModel.members
          ?.firstWhere((element) => element.id != member.id);
      await _pushNotificationApi.sendNotification(
        request: SendNotificationRequest(
          notification: NotificationRequest(
            title: 'Tương hợp mới',
            body: 'Bạn có một tương hợp mới với ${member.name}',
            sound: 'new_message',
            alert: true,
          ),
          data: NotificationPayload(
            notificationType: NotificationType.match,
            channelModel: channelModel,
          ).toJson(),
          userIds: [anotherMember?.id ?? ''],
        ).toJson(),
      );
    }
  }
}
