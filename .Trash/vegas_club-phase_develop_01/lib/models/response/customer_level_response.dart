// To parse this JSON data, do
//
//     final customerLevelResponse = customerLevelResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
part "customer_level_response.g.dart";

List<CustomerLevelResponse> customerLevelResponseFromJson(String str) =>
    List<CustomerLevelResponse>.from(
        json.decode(str).map((x) => CustomerLevelResponse.fromJson(x)));

String customerLevelResponseToJson(List<CustomerLevelResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 6)
class CustomerLevelResponse {
  CustomerLevelResponse({
    this.level,
    this.type,
  });

  @HiveField(0)
  String? level;
  @HiveField(1)
  List<String>? type;

  CustomerLevelResponse copyWith({
    String? level,
    List<String>? type,
  }) =>
      CustomerLevelResponse(
        level: level ?? this.level,
        type: type ?? this.type,
      );

  factory CustomerLevelResponse.fromJson(Map<String, dynamic> json) =>
      CustomerLevelResponse(
        level: json["level"],
        type: List<String>.from(json["type"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "level": level,
        "type": List<dynamic>.from(type!.map((x) => x)),
      };
}
