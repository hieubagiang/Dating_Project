import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../common/utils/date_time.dart';

part 'photo_model.g.dart';

@JsonSerializable()
class PhotoModel {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'url')
  final String url;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  PhotoModel({
    required this.id,
    required this.url,
    required this.createAt,
    this.updateAt,
  });

  factory PhotoModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      PhotoModel.fromJson(snapshot.data() ?? {});

  factory PhotoModel.fromJson(Map<String, dynamic> json) =>
      _$PhotoModelFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoModelToJson(this);

  @override
  String toString() {
    return 'PhotoModel{id: $id, url: $url}';
  }
}
