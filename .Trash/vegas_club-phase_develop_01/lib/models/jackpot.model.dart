// To parse this JSON data, do
//
//     final jackpot = jackpotFromJson(jsonString);

import 'dart:convert';

List<Jackpot> jackpotFromJson(String str) =>
    List<Jackpot>.from(json.decode(str).map((x) => Jackpot.fromJson(x)));

String jackpotToJson(List<Jackpot> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jackpot {
  Jackpot({
    this.date,
    this.subject,
  });

  final String? date;
  final List<String>? subject;

  Jackpot copyWith({
    String? date,
    List<String>? subject,
  }) =>
      Jackpot(
        date: date ?? this.date,
        subject: subject ?? this.subject,
      );

  factory Jackpot.fromJson(Map<String, dynamic> json) => Jackpot(
        date: json["date"],
        subject: List<String>.from(json["subject"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "subject": List<dynamic>.from(subject!.map((x) => x)),
      };
}
