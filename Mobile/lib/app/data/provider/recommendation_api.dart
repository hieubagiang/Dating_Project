import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/get_recommendation_response.dart';

part 'recommendation_api.g.dart';

@RestApi()
abstract class RecommendationApi {
  factory RecommendationApi(Dio dio, {String baseUrl}) = _RecommendationApi;

  @GET("/api/get_recommendation")
  Future<GetRecommendationResponse> getRecommendation({
    @Header('Authorization') required String bearerToken,
    @Queries() required Map<String, dynamic> request,
  });
}
