// To parse this JSON data, do
//
//     final settingValueModel = settingValueModelFromJson(jsonString);

import 'dart:convert';

List<SettingValueModel> settingValueModelFromJson(String str) =>
    List<SettingValueModel>.from(
        json.decode(str).map((x) => SettingValueModel.fromJson(x)));

String settingValueModelToJson(List<SettingValueModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingValueModel {
  SettingValueModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  SettingValueModel copyWith({
    int? id,
    String? name,
  }) =>
      SettingValueModel(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory SettingValueModel.fromJson(Map<String, dynamic> json) =>
      SettingValueModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
