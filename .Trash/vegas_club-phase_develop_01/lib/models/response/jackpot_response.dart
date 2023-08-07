// To parse this JSON data, do
//
//     final jackpotResponse = jackpotResponseFromJson(jsonString);

import 'dart:convert';

List<JackpotResponse> jackpotResponseFromJson(String str) =>
    List<JackpotResponse>.from(
        json.decode(str).map((x) => JackpotResponse.fromJson(x)));

String jackpotResponseToJson(List<JackpotResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JackpotResponse {
  JackpotResponse({
    this.id,
    this.mcNumber,
    this.mcName,
    this.jpDate,
    this.jpValue,
    this.jackpotGameTypeId,
    this.jackpotGameType,
  });

  int? id;
  int? mcNumber;
  String? mcName;
  DateTime? jpDate;
  dynamic jpValue;
  int? jackpotGameTypeId;
  JackpotGameType? jackpotGameType;

  JackpotResponse copyWith({
    int? id,
    int? mcNumber,
    String? mcName,
    DateTime? jpDate,
    dynamic jpValue,
    int? jackpotGameTypeId,
    JackpotGameType? jackpotGameType,
  }) =>
      JackpotResponse(
        id: id ?? this.id,
        mcNumber: mcNumber ?? this.mcNumber,
        mcName: mcName ?? this.mcName,
        jpDate: jpDate ?? this.jpDate,
        jpValue: jpValue ?? this.jpValue,
        jackpotGameTypeId: jackpotGameTypeId ?? this.jackpotGameTypeId,
        jackpotGameType: jackpotGameType ?? this.jackpotGameType,
      );

  factory JackpotResponse.fromJson(Map<String, dynamic> json) =>
      JackpotResponse(
        id: json["id"],
        mcNumber: json["mc_number"],
        mcName: json["mc_name"],
        jpDate:
            json["jp_date"] == null ? null : DateTime.parse(json["jp_date"]),
        jpValue: json["jp_value"],
        jackpotGameTypeId: json["jackpot_game_type_id"],
        jackpotGameType: json["jackpot_game_type"] == null
            ? null
            : JackpotGameType.fromJson(json["jackpot_game_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mc_number": mcNumber,
        "mc_name": mcName,
        "jp_date": jpDate == null ? null : jpDate!.toIso8601String(),
        "jp_value": jpValue,
        "jackpot_game_type_id": jackpotGameTypeId,
        "jackpot_game_type": jackpotGameType!.toJson(),
      };
}

class JackpotGameType {
  JackpotGameType({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  JackpotGameType copyWith({
    int? id,
    String? name,
  }) =>
      JackpotGameType(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory JackpotGameType.fromJson(Map<String, dynamic> json) =>
      JackpotGameType(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
