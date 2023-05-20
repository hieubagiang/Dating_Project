import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../common/utils/date_time.dart';

part 'position_model.g.dart';

@JsonSerializable()
class PositionModel {
  @JsonKey(name: 'latitude')
  final double latitude;
  @JsonKey(name: 'longitude')
  final double longitude;
  @JsonKey(name: 'address')
  final String? address;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  PositionModel({
    required this.longitude,
    required this.latitude,
    this.address,
    this.createAt,
    this.updateAt,
  }) : super();

  factory PositionModel.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return PositionModel.fromJson(snapshot.data() ?? {});
  }

  factory PositionModel.fromPosition(Position position) {
    return PositionModel.fromJson(position.toJson());
  }

  PositionModel copyWith(
          {String? address,
          double? longitude,
          double? latitude,
          DateTime? createAt}) =>
      PositionModel(
          longitude: longitude ?? this.longitude,
          latitude: latitude ?? this.latitude,
          address: address ?? this.address,
          createAt: createAt ?? this.createAt);

  factory PositionModel.fromJson(Map<String, dynamic> json) =>
      _$PositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PositionModelToJson(this);
}
