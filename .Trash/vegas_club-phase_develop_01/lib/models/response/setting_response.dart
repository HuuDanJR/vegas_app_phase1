// To parse this JSON data, do
//
//     final settingResponse = settingResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'setting_response.g.dart';

List<SettingResponse> settingResponseFromJson(String str) =>
    List<SettingResponse>.from(
        json.decode(str).map((x) => SettingResponse.fromJson(x)));

String settingResponseToJson(List<SettingResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
@HiveType(typeId: 3)
class SettingResponse {
  SettingResponse({
    this.id,
    this.settingKey,
    this.settingValue,
    this.description,
  });

  @JsonKey(name: "id")
  @HiveField(0)
  int? id;
  @JsonKey(name: "setting_key")
  @HiveField(1)
  String? settingKey;
  @JsonKey(name: "setting_value")
  @HiveField(2)
  String? settingValue;
  @JsonKey(name: "description")
  @HiveField(3)
  String? description;

  SettingResponse copyWith({
    int? id,
    String? settingKey,
    String? settingValue,
    String? description,
  }) =>
      SettingResponse(
        id: id ?? this.id,
        settingKey: settingKey ?? this.settingKey,
        settingValue: settingValue ?? this.settingValue,
        description: description ?? this.description,
      );

  factory SettingResponse.fromJson(Map<String, dynamic> json) =>
      _$SettingResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SettingResponseToJson(this);
}
