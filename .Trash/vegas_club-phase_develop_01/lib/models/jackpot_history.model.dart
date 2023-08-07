// To parse this JSON data, do
//
//     final jackpot = jackpotFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'jackpot_history.model.g.dart';

List<JackpotHistory> jackpotFromJson(String str) => List<JackpotHistory>.from(
    json.decode(str).map((x) => JackpotHistory.fromJson(x)));

String jackpotToJson(List<JackpotHistory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class JackpotHistory {
  JackpotHistory({
    this.date,
    this.mcNo,
    this.jackpot,
    this.mcName,
    this.amount,
  });

  @JsonKey(name: "DATE")
  final String? date;
  @JsonKey(name: "MC NO.")
  final int? mcNo;
  @JsonKey(name: "JACKPOT")
  final String? jackpot;
  @JsonKey(name: "MC NAME")
  final String? mcName;
  @JsonKey(name: "AMOUNT")
  final String? amount;

  JackpotHistory copyWith({
    String? date,
    int? mcNo,
    String? jackpot,
    String? mcName,
    String? amount,
  }) =>
      JackpotHistory(
        date: date ?? this.date,
        mcNo: mcNo ?? this.mcNo,
        jackpot: jackpot ?? this.jackpot,
        mcName: mcName ?? this.mcName,
        amount: amount ?? this.amount,
      );

  factory JackpotHistory.fromJson(Map<String, dynamic> json) =>
      _$JackpotHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$JackpotHistoryToJson(this);
}
