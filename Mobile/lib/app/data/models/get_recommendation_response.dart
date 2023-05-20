import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'pagination.dart';

part 'get_recommendation_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GetRecommendationResponse {
  GetRecommendationResponse({
    this.data,
    this.pagination,
  });

  final List<UserModel>? data;
  final Pagination? pagination;

  GetRecommendationResponse copyWith({
    List<UserModel>? data,
    Pagination? pagination,
  }) =>
      GetRecommendationResponse(
        data: data ?? this.data,
        pagination: pagination ?? this.pagination,
      );

  factory GetRecommendationResponse.fromJson(Map<String, dynamic> json) =>
      _$GetRecommendationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetRecommendationResponseToJson(this);
}
