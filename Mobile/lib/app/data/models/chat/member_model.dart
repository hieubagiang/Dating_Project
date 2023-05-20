import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:json_annotation/json_annotation.dart';
part 'member_model.g.dart';

@JsonSerializable(explicitToJson: true)
class MemberModel {
  MemberModel({this.id, this.name, this.avatarUrl, this.unreadCount = 0});

  @JsonKey(name: 'id')
  final String? id;
  @JsonKey(name: 'name')
  final String? name;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @JsonKey(name: 'unread_count')
  final int unreadCount;

  MemberModel copyWith({
    String? id,
    String? name,
    String? avatarUrl,
    int? unreadCount,
  }) =>
      MemberModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatarUrl: avatarUrl ?? this.avatarUrl,
        unreadCount: unreadCount ?? this.unreadCount,
      );

  factory MemberModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      MemberModel.fromJson(snapshot.data() ?? {});

  factory MemberModel.fromJson(Map<String, dynamic> json) =>
      _$MemberModelFromJson(json);

  Map<String, dynamic> toJson() => _$MemberModelToJson(this)..removeNulls();

  @override
  String toString() {
    return 'MemberModel{id: $id, name: $name, avatarUrl: $avatarUrl, unreadCount: $unreadCount}';
  }
}
