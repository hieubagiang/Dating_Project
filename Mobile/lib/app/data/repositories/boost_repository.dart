import 'package:dating_app/app/data/models/boost/boost_model.dart';
import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:dating_app/app/data/provider/boost/boost_api.dart';

abstract class BoostRepository {
  Future<void> boostProfile();

  Stream<List<UserModel>> listenToTopPickListRealTime();
  Stream<BoostModel?> listenToUserBoostStatusRealTime();

  void requestMoreTopPickData();
}

class BoostRepositoryImpl extends BoostRepository {
  final api = BoostApiImplement();

  //Getting userId.
  String? get currentUserId => api.userId;

  @override
  Future<void> boostProfile() {
    return api.boostProfile();
  }

  @override
  Stream<List<UserModel>> listenToTopPickListRealTime() {
    return api.listenToTopPickListRealTime(currentUserId ?? '');
  }

  @override
  void requestMoreTopPickData() {
    api.requestMoreTopPickData(currentUserId ?? '');
  }

  @override
  Stream<BoostModel?> listenToUserBoostStatusRealTime() {
    return api.listenToUserBoostStatusRealTime(userId: api.userId!);
  }
}
