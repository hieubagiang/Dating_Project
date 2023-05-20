import 'package:dating_app/app/data/models/user_model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../chat/member_model.dart';

part 'basic_user.freezed.dart';
part 'basic_user.g.dart';

@freezed
class BasicUserModel with _$BasicUserModel {
  @JsonSerializable(
    fieldRename: FieldRename.snake,
  )
  const factory BasicUserModel({
    required String id,
    required String name,
    required String avatar,
  }) = _BasicUserModel;

  const BasicUserModel._();
  factory BasicUserModel.fromJson(Map<String, dynamic> json) =>
      _$BasicUserModelFromJson(json);

  factory BasicUserModel.fromUserModel(UserModel model) => BasicUserModel(
        id: model.id ?? '',
        name: model.name ?? '',
        avatar: model.avatarUrl,
      );
  factory BasicUserModel.fromMemberModel(MemberModel model) => BasicUserModel(
        id: model.id ?? '',
        name: model.name ?? '',
        avatar: model.avatarUrl ?? '',
      );
}
