import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../enums/hobby_enum.dart';

part 'hobby_model.g.dart';

@JsonSerializable()
class HobbyModel extends Equatable {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'name')
  final String name;

  HobbyModel({
    required this.id,
    required this.name,
  });

  String? get label => HobbyTypeEnum.getType(id)?.label;
  factory HobbyModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      HobbyModel.fromJson(snapshot.data() ?? {});

  factory HobbyModel.fromJson(Map<String, dynamic> json) =>
      _$HobbyModelFromJson(json);

  Map<String, dynamic> toJson() => _$HobbyModelToJson(this);

  @override
  List<Object?> get props => [id, name];
}
