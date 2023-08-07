// To parse this JSON data, do
//
//     final dateOfSeasonResponse = dateOfSeasonResponseFromJson(jsonString);

import 'dart:convert';

List<DateOfSeasonResponse> dateOfSeasonResponseFromJson(String str) =>
    List<DateOfSeasonResponse>.from(
        json.decode(str).map((x) => DateOfSeasonResponse.fromJson(x)));

String dateOfSeasonResponseToJson(List<DateOfSeasonResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DateOfSeasonResponse {
  DateOfSeasonResponse({
    this.month,
    this.day,
  });

  int? month;
  List<int>? day;

  DateOfSeasonResponse copyWith({
    int? month,
    List<int>? day,
  }) =>
      DateOfSeasonResponse(
        month: month ?? this.month,
        day: day ?? this.day,
      );

  factory DateOfSeasonResponse.fromJson(Map<String, dynamic> json) =>
      DateOfSeasonResponse(
        month: json["month"],
        day: List<int>.from(json["day"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "day": List<dynamic>.from(day!.map((x) => x)),
      };
}

class DateOfSeason {
  DateOfSeason({
    this.month,
    this.day,
  });

  int? month;
  List<int>? day;

  DateOfSeason copyWith({
    int? month,
    List<int>? day,
  }) =>
      DateOfSeason(
        month: month ?? this.month,
        day: day ?? this.day,
      );

  factory DateOfSeason.fromJson(Map<String, dynamic> json) => DateOfSeason(
        month: json["month"],
        day: List<int>.from(json["day"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "day": List<dynamic>.from(day!.map((x) => x)),
      };
}
