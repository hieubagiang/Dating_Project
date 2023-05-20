import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/date_time.dart';
import 'package:json_annotation/json_annotation.dart';

part 'boost_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BoostModel {
  @JsonKey(name: 'user_id')
  final String userId;
  @JsonKey(name: 'expire_at', fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? expireAt;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: coordinatesToJson)
  final DateTime? updateAt;

  static String coordinatesToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  factory BoostModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      BoostModel.fromJson(snapshot.data() ?? {});

  factory BoostModel.fromJson(Map<String, dynamic> json) =>
      _$BoostModelFromJson(json);

  BoostModel(
      {this.updateAt,
      required this.userId,
      required this.expireAt,
      required this.createAt})
      : super();

  Map<String, dynamic> toJson() => _$BoostModelToJson(this);

  BoostModel copyWith(
      {String? userId,
      DateTime? createAt,
      DateTime? expireAt,
      DateTime? updateAt}) {
    return BoostModel(
        userId: userId ?? this.userId,
        expireAt: expireAt ?? this.expireAt,
        createAt: createAt ?? this.createAt);
  }

  @override
  String toString() {
    return 'BoostModel{userId: $userId, expireAt: $expireAt}';
  }
}
