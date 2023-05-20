import 'package:dating_app/app/data/models/chat/channel_model.dart';
import 'package:dating_app/app/data/models/interaction/interacted_user.dart';
import 'package:dating_app/app/data/models/interaction/matched_user_model.dart';
import 'package:dating_app/app/data/provider/match_api/match_api.dart';
import 'package:get/get.dart';

abstract class _MatchesRepository {
  Stream<List<InteractedUserModel>> listenToLikedListRealTime();

  Stream<List<InteractedUserModel>> listenToChosenListRealTime();

  Stream<List<MatchedUserModel>> listenToMatchedListRealTime();

  Future<List<ChannelModel>> queryMatchedList({required String name});

  void requestMoreLikedData();

  void requestMoreChosenData();
}

class MatchesRepository extends _MatchesRepository {
  final _api = Get.find<MatchApiImplement>();

  @override
  Stream<List<InteractedUserModel>> listenToLikedListRealTime() {
    return _api.listenToLikedListRealTime();
  }

  @override
  Stream<List<InteractedUserModel>> listenToChosenListRealTime() {
    return _api.listenToChosenListRealTime();
  }

  @override
  void requestMoreLikedData() {
    return _api.requestMoreLikedData();
  }

  @override
  void requestMoreChosenData() {
    return _api.requestMoreLikedData();
  }

  @override
  Stream<List<MatchedUserModel>> listenToMatchedListRealTime() async* {
    yield* _api.listenToMatchedListRealTime();
  }

  @override
  Future<List<ChannelModel>> queryMatchedList({required String name}) {
    return _api.queryMatchedList(name: name);
  }
}
