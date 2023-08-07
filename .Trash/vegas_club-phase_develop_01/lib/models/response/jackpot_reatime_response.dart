// To parse this JSON data, do
//
//     final jackpotRealtimeResponse = jackpotRealtimeResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'jackpot_reatime_response.g.dart';

JackpotRealtimeResponse jackpotRealtimeResponseFromJson(String str) =>
    JackpotRealtimeResponse.fromJson(json.decode(str));

String jackpotRealtimeResponseToJson(JackpotRealtimeResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class JackpotRealtimeResponse {
  JackpotRealtimeResponse({
    this.lastUpdate,
    this.data,
  });

  @JsonKey(name: "last_update")
  DateTime? lastUpdate;
  @JsonKey(name: "data")
  List<Datum>? data;

  JackpotRealtimeResponse copyWith({
    DateTime? lastUpdate,
    List<Datum>? data,
  }) =>
      JackpotRealtimeResponse(
        lastUpdate: lastUpdate ?? this.lastUpdate,
        data: data ?? this.data,
      );

  factory JackpotRealtimeResponse.fromJson(Map<String, dynamic> json) =>
      JackpotRealtimeResponse(
        lastUpdate: DateTime.parse(json["last_update"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "last_update": lastUpdate!.toIso8601String(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListDatumModel {
  String? name;
  List<dynamic>? value;
  String? max;
  String? min;

  ListDatumModel({this.name, this.value, this.max, this.min});

  bool isNearMax() {
    String maxText =
    max != null ? max!.substring(1, max!.length).replaceAll(",", "") : "0";
    String minText = min != null
        ? min!.substring(1, (min!).length).replaceAll(",", "")
        : "0";
    int? maxNum = int.tryParse(maxText);
    int? minNum = int.tryParse(minText);
    int? valueNum = value!.first!.toInt();
    double percentage = ((valueNum! - minNum!) * 100) / (maxNum! - minNum);
    if (percentage >= 70) {
      return true;
    }
    return false;
  }

  double getPercentageOfValueInMax() {
    String maxText = max!.substring(1, max!.length).replaceAll(",", "");
    String minText = min!.substring(1, min!.length).replaceAll(",", "");
    int? maxNum = int.tryParse(maxText);
    int? minNum = int.tryParse(minText);
    int? valueNum = value!.first!.toInt();
    double percentage = ((valueNum! - minNum!) * 100) / (maxNum! - minNum);
    return percentage;
  }
}

@JsonSerializable()
class Datum {
  Datum({
    this.name,
    this.value,
    this.max,
    this.min,
  });

  String? name;
  dynamic value;
  String? max;
  String? min;

  Datum copyWith({
    String? name,
    dynamic value,
    String? max,
    String? min,
  }) =>
      Datum(
        name: name ?? this.name,
        value: value ?? this.value,
        max: max ?? this.max,
        min: min ?? this.min,
      );

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        value: json["value"],
        max: json["max"],
        min: json["min"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
        "max": max,
        "min": min,
      };

  bool isNearMax() {
    String maxText =
        max != null ? max!.substring(1, max!.length).replaceAll(",", "") : "0";
    String minText = min != null
        ? min!.substring(1, (min!).length).replaceAll(",", "")
        : "0";
    int? maxNum = int.tryParse(maxText);
    int? minNum = int.tryParse(minText);
    int? valueNum = value!.toInt();
    double percentage = ((valueNum! - minNum!) * 100) / (maxNum! - minNum);
    if (percentage >= 70) {
      return true;
    }
    return false;
  }

  double getPercentageOfValueInMax() {
    String maxText = max!.substring(1, max!.length).replaceAll(",", "");
    String minText = min!.substring(1, min!.length).replaceAll(",", "");
    int? maxNum = int.tryParse(maxText);
    int? minNum = int.tryParse(minText);
    int? valueNum = value!.toInt();
    double percentage = ((valueNum! - minNum!) * 100) / (maxNum! - minNum);
    return percentage;
  }
}
