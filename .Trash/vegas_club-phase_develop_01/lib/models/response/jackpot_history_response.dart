// To parse this JSON data, do
//
//     final jackpotHistoryResponse = jackpotHistoryResponseFromJson(jsonString);

import 'dart:convert';

List<JackpotHistoryResponse> jackpotHistoryResponseFromJson(String str) =>
    List<JackpotHistoryResponse>.from(
        json.decode(str).map((x) => JackpotHistoryResponse.fromJson(x)));

String jackpotHistoryResponseToJson(List<JackpotHistoryResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JackpotHistoryResponse {
  JackpotHistoryResponse({
    this.date,
    this.name,
    this.machineNumber,
    this.machineName,
    this.amount,
  });

  DateTime? date;
  String? name;
  String? machineNumber;
  String? machineName;
  double? amount;

  JackpotHistoryResponse copyWith({
    DateTime? date,
    String? name,
    String? machineNumber,
    String? machineName,
    double? amount,
  }) =>
      JackpotHistoryResponse(
        date: date ?? this.date,
        name: name ?? this.name,
        machineNumber: machineNumber ?? this.machineNumber,
        machineName: machineName ?? this.machineName,
        amount: amount ?? this.amount,
      );

  factory JackpotHistoryResponse.fromJson(Map<String, dynamic> json) =>
      JackpotHistoryResponse(
        date: DateTime.parse(json["jp_date"]),
        name: json["jp_game_name"],
        machineNumber: json["mc_number"],
        machineName: json["mc_name"],
        amount: json["jp_value"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "jp_date": date!.toIso8601String(),
        "jp_game_name": name,
        "mc_number": machineNumber,
        "mc_name": machineName,
        "jp_value": amount,
      };
}
