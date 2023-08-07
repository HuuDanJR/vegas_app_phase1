// To parse this JSON data, do
//
//     final settingModel = settingModelFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
part 'setting_model.g.dart';

SettingModel settingModelFromJson(String str) =>
    SettingModel.fromJson(json.decode(str));

String settingModelToJson(SettingModel data) => json.encode(data.toJson());

@JsonSerializable()
@HiveType(typeId: 4)
class SettingModel {
  SettingModel({
    this.status,
    this.reservation,
    this.type,
  });
  @HiveField(0)
  @JsonKey(name: "status")
  List<SettingItem>? status;
  @HiveField(1)
  @JsonKey(name: "reservation")
  List<SettingItem>? reservation;
  @HiveField(2)
  @JsonKey(name: "type")
  List<SettingItem>? type;

  SettingModel copyWith({
    List<SettingItem>? status,
    List<SettingItem>? reservation,
    List<SettingItem>? type,
  }) =>
      SettingModel(
        status: status ?? this.status,
        reservation: reservation ?? this.reservation,
        type: type ?? this.type,
      );

  factory SettingModel.fromJson(Map<String, dynamic> json) =>
      _$SettingModelFromJson(json);

  Map<String, dynamic> toJson() => _$SettingModelToJson(this);
}

@JsonSerializable()
@HiveType(typeId: 5)
class SettingItem {
  SettingItem({
    this.id,
    this.name,
  });
  @HiveField(0)
  @JsonKey(name: "id")
  int? id;
  @HiveField(1)
  @JsonKey(name: "name")
  String? name;

  SettingItem copyWith({
    int? id,
    String? name,
  }) =>
      SettingItem(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory SettingItem.fromJson(Map<String, dynamic> json) =>
      _$SettingItemFromJson(json);

  Map<String, dynamic> toJson() => _$SettingItemToJson(this);
}
