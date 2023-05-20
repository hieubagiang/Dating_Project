import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/index.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'age_range_model.dart';

part 'filter_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FeedFilterModel extends Equatable {
  @JsonKey(name: 'distance')
  final double? distance;
  @JsonKey(name: 'interested_in_gender')
  final int? interestedInGender;
  @JsonKey(name: 'age_range')
  final AgeRangeModel? ageRange;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  factory FeedFilterModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      FeedFilterModel.fromJson(snapshot.data() ?? {});

  factory FeedFilterModel.fromJson(Map<String, dynamic> json) =>
      _$FeedFilterModelFromJson(json);

  Map<String, dynamic> toJson() => _$FeedFilterModelToJson(this)..removeNulls();

  const FeedFilterModel({
    this.createAt,
    this.updateAt,
    this.distance,
    this.interestedInGender,
    this.ageRange,
  });

  factory FeedFilterModel.init() => FeedFilterModel(
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        distance: 100,
        ageRange: AgeRangeModel(),
      );

  FeedFilterModel copyWith({
    double? distance,
    int? interestedInGender,
    AgeRangeModel? ageRange,
  }) =>
      FeedFilterModel(
        distance: distance ?? this.distance,
        interestedInGender: interestedInGender ?? this.interestedInGender,
        ageRange: ageRange ?? this.ageRange,
      );

  @override
  List<Object?> get props => [
        distance,
        interestedInGender,
        ageRange,
        createAt,
        updateAt,
      ];
}
