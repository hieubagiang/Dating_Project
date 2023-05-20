import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import 'matched_user_model.dart';

part 'interacted_user.g.dart';

@JsonSerializable(explicitToJson: true)
class InteractedUserModel {
  @JsonKey(name: 'current_user_id')
  final String currentUserId;
  @JsonKey(name: 'current_user')
  final MatchedUserModel currentUser;
  @JsonKey(name: 'interacted_user_id')
  final String interactedUserId;
  @JsonKey(name: 'interacted_user')
  final MatchedUserModel interactedUser;
  @JsonKey(
      name: 'interacted_type') //1: dislike 2: like  3: super_like (coming_soon)
  final int interactedType;
  @JsonKey(name: 'update_at')
  final DateTime updateAt;
  @JsonKey(name: 'chat_channel_id')
  final String? chatChannelId;
  factory InteractedUserModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      InteractedUserModel.fromJson(snapshot.data() ?? {});

  factory InteractedUserModel.fromJson(Map<String, dynamic> json) =>
      _$InteractedUserModelFromJson(json);

  InteractedUserModel({
    required this.currentUser,
    required this.interactedUser,
    required this.interactedType,
    required this.updateAt,
    required this.currentUserId,
    required this.interactedUserId,
    this.chatChannelId,
  });

  Map<String, dynamic> toJson() => _$InteractedUserModelToJson(this);

  InteractedUserModel copyWith(
      {MatchedUserModel? currentUser,
      MatchedUserModel? interactedUser,
      int? interactedType,
      String? currentUserId,
      String? interactedUserId,
      String? chatChannelId,
      DateTime? updateAt}) {
    return InteractedUserModel(
        currentUser: currentUser ?? this.currentUser,
        interactedUser: interactedUser ?? this.interactedUser,
        interactedType: interactedType ?? this.interactedType,
        updateAt: DateTime.now(),
        interactedUserId: interactedUserId ?? this.interactedUserId,
        currentUserId: currentUserId ?? this.currentUserId);
  }

  String get uniKey => '${currentUser.username}_${interactedUser.username}';

  @override
  String toString() {
    return 'InteractedUserModel{currentUserId: $currentUserId, currentUser: $currentUser, interactedUserId: $interactedUserId, interactedUser: $interactedUser, interactedType: $interactedType, updateAt: $updateAt}';
  }
}
