import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../models/get_recommendation_response.dart';

part 'notification_api.g.dart';

@RestApi()
@injectable
abstract class NotificationApi {
  @factoryMethod
  factory NotificationApi(Dio dio, {String baseUrl}) = _NotificationApi;

  @POST("/api/notification/send_notification")
  Future<GetRecommendationResponse> sendNotification({
    @Body() required Map<String, dynamic> request,
  });
}
