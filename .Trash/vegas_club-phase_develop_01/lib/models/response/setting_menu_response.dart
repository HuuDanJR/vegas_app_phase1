// To parse this JSON data, do
//
//     final settingMenuResponse = settingMenuResponseFromJson(jsonString);

import 'dart:convert';

List<SettingMenuResponse> settingMenuResponseFromJson(String str) =>
    List<SettingMenuResponse>.from(
        json.decode(str).map((x) => SettingMenuResponse.fromJson(x)));

String settingMenuResponseToJson(List<SettingMenuResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SettingMenuResponse {
  SettingMenuResponse({
    this.name,
    this.value,
  });

  String? name;
  int? value;

  SettingMenuResponse copyWith({
    String? name,
    int? value,
  }) =>
      SettingMenuResponse(
        name: name ?? this.name,
        value: value ?? this.value,
      );

  factory SettingMenuResponse.fromJson(Map<String, dynamic> json) =>
      SettingMenuResponse(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
