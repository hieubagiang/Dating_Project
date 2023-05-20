import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/get_recommendation_response.dart';
import '../models/pagination.dart';
import '../provider/recommendation_api.dart';

class RecommendationRepository {
  final RecommendationApi api = Get.find<RecommendationApi>();

  Future<GetRecommendationResponse?> getRecommendation(
    Pagination pagination,
  ) async {
    try {
      final token = await FirebaseAuth.instance.currentUser?.getIdToken();
      final result = await api.getRecommendation(
        bearerToken: token ?? '',
        request: pagination.toJson()..removeNulls(),
      );
      return result;
    } catch (exception) {
      debugPrint(exception.toString());
      return null;
    }
  }
}
