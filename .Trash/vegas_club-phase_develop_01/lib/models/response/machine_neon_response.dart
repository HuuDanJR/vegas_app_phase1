// To parse this JSON data, do
//
//     final machineNeonResponse = machineNeonResponseFromJson(jsonString);

import 'dart:convert';

MachineNeonResponse machineNeonResponseFromJson(String str) =>
    MachineNeonResponse.fromJson(json.decode(str));

String machineNeonResponseToJson(MachineNeonResponse data) =>
    json.encode(data.toJson());

class MachineNeonResponse {
  MachineNeonResponse({
    this.number,
    this.name,
    this.machineGameThemeId,
  });

  int? number;
  String? name;
  int? machineGameThemeId;

  MachineNeonResponse copyWith({
    int? number,
    String? name,
    int? machineGameThemeId,
  }) =>
      MachineNeonResponse(
        number: number ?? this.number,
        name: name ?? this.name,
        machineGameThemeId: machineGameThemeId ?? this.machineGameThemeId,
      );

  factory MachineNeonResponse.fromJson(Map<String, dynamic> json) =>
      MachineNeonResponse(
        number: json["number"],
        name: json["name"],
        machineGameThemeId: json["machine_game_theme_id"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "name": name,
        "machine_game_theme_id": machineGameThemeId,
      };
}
