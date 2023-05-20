import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/date_time.dart';
import 'package:dating_app/app/data/models/chat/member_model.dart';
import 'package:dating_app/app/data/models/user_model/position_model/position_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'matched_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MatchedUserModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'username')
  final String username;
  @JsonKey(name: 'birthday')
  final DateTime birthday;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'location')
  final PositionModel? location;
  @JsonKey(name: "create_at", fromJson: DateTimeUtils.dateTimeFromJson)
  final DateTime? createAt;
  @JsonKey(
      name: "update_at",
      fromJson: DateTimeUtils.dateTimeFromJson,
      toJson: updateAtToJson)
  final DateTime? updateAt;

  static String updateAtToJson(DateTime? updatedAt) =>
      DateTime.now().toIso8601String();

  MatchedUserModel({
    required this.id,
    required this.name,
    required this.username,
    required this.birthday,
    required this.avatarUrl,
    this.location,
    required this.createAt,
    this.updateAt,
  });

  factory MatchedUserModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      MatchedUserModel.fromJson(snapshot.data() ?? {});

  factory MatchedUserModel.fromJson(Map<String, dynamic> json) =>
      _$MatchedUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$MatchedUserModelToJson(this);

  MatchedUserModel copyWith({
    String? id,
    String? name,
    DateTime? birthday,
    DateTime? createAt,
    String? avatarUrl,
    String? username,
    PositionModel? location,
  }) {
    return MatchedUserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      location: location ?? this.location,
      username: username ?? this.username,
      createAt: createAt ?? this.createAt,
    );
  }

  int get age => DateTimeUtils.calculateAge(birthday);

  MemberModel toMemberModel() {
    return MemberModel(id: id, name: name, avatarUrl: avatarUrl);
  }

  @override
  String toString() {
    return 'MatchedUserModel{id: $id, name: $name,username: $username, birthday: $birthday, avatarUrl: $avatarUrl, location: $location}';
  }
}
