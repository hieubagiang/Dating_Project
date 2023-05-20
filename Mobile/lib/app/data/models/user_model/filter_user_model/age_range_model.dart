import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/app/common/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'age_range_model.g.dart';

@JsonSerializable(explicitToJson: true)
class AgeRangeModel {
  @JsonKey(name: 'start')
  final int? start;
  @JsonKey(name: 'end')
  final int? end;

  factory AgeRangeModel.fromSnapShot(
          DocumentSnapshot<Map<String, dynamic>> snapshot) =>
      AgeRangeModel.fromJson(snapshot.data() ?? {});

  factory AgeRangeModel.fromJson(Map<String, dynamic> json) =>
      _$AgeRangeModelFromJson(json);

  factory AgeRangeModel.fromRangeValues(RangeValues rangeValues) =>
      AgeRangeModel(
          start: rangeValues.start.toInt(), end: rangeValues.end.toInt());
  RangeValues toRangeValue() => RangeValues(start!.toDouble(), end!.toDouble());
  AgeRangeModel({this.start = 16, this.end = 40});

  Map<String, dynamic> toJson() => _$AgeRangeModelToJson(this)..removeNulls();
}
