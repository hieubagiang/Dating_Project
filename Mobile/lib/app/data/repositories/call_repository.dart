import 'package:dating_app/app/data/models/call/call_model.dart';
import 'package:dating_app/app/data/provider/chat/chat_api.dart';
import 'package:dating_app/app/data/provider/recommendation_api.dart';
import 'package:dating_app/app/data/provider/user_api.dart';
import 'package:get/get.dart';

import '../provider/call_api.dart';

abstract class _CallRepository {
  Future<void> changeCall({required CallModel callModel});

  Future<void> ringPhone({required CallModel callModel});

  Future<CallModel?> getCallInfo({required String callId});
}

class CallRepository extends _CallRepository {
  final CallApi _api = Get.find<CallApi>();
  final UserApi _userApi = Get.find<UserApi>();
  final ChatApi _chatApi = Get.find<ChatApiImpl>();
  final RecommendationApi _recommendationApi = Get.find<RecommendationApi>();

  @override
  Future<void> ringPhone({required CallModel callModel}) {
    return _api.ringPhone(callModel: callModel);
  }

  @override
  Future<void> changeCall({required CallModel callModel}) {
    return _api.setCallStatus(callModel: callModel);
  }

  @override
  Future<CallModel?> getCallInfo({required String callId}) async {
    return _api.getCallInfo(callId: callId);
  }

  void stopRinging({required CallModel callModel}) {
    _api.setCallStatus(callModel: callModel);
  }
}
