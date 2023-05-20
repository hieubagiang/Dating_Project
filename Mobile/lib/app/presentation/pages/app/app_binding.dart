import 'package:dating_app/app/common/network/dio_builder.dart';
import 'package:dating_app/app/data/provider/api_provider.dart';
import 'package:dating_app/app/data/provider/auth_api.dart';
import 'package:dating_app/app/data/provider/call_api.dart';
import 'package:dating_app/app/data/provider/chat/chat_api.dart';
import 'package:dating_app/app/data/provider/feed_api.dart';
import 'package:dating_app/app/data/provider/hobby_api.dart';
import 'package:dating_app/app/data/provider/match_api/match_api.dart';
import 'package:dating_app/app/data/provider/notification_api.dart';
import 'package:dating_app/app/data/provider/recommendation_api.dart';
import 'package:dating_app/app/data/provider/storage_api.dart';
import 'package:dating_app/app/data/provider/user_api.dart';
import 'package:dating_app/app/data/repositories/auth_repository.dart';
import 'package:dating_app/app/data/repositories/boost_repository.dart';
import 'package:dating_app/app/data/repositories/call_repository.dart';
import 'package:dating_app/app/data/repositories/feed_repository.dart';
import 'package:dating_app/app/data/repositories/matches_repository.dart';
import 'package:dating_app/app/data/repositories/storage_repository.dart';
import 'package:dating_app/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../../../data/provider/payment_api/payment_api.dart';
import '../../../data/repositories/payment_repository.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      DioBuilder().getDio(),
      permanent: true,
    );
    Get.put(
      Api(),
    );
    Get.put(
      RecommendationApi(Get.find()),
    );
    Get.put(UserApi());
    Get.put(
      FeedApi(),
    );
    Get.put(
      UserApi(),
    );
    Get.put(
      ChatApiImpl(),
    );
    Get.put(
      NotificationApi(Get.find()),
    );
    Get.put(
      MatchApiImplement(),
    );
    Get.put(
      HobbyApi(),
    );
    Get.put(
      StorageApi(),
    );
    Get.put(
      AuthApi(),
    );
    Get.put(
      CallApi(),
    );
    Get.put(
      PaymentApi(Get.find()),
    );
    Get.put(
      AuthRepository(),
    );

    Get.put(
      UserRepository(),
    );
    Get.put(
      BoostRepositoryImpl(),
    );
    Get.put(
      UserRepository(),
    );
    Get.put(
      FeedRepository(),
    );
    Get.put(
      MatchesRepository(),
    );
    Get.put(
      StorageRepository(),
    );

    Get.put(
      CallRepository(),
    );
    Get.put(
      PaymentRepository(),
    );
  }
}
