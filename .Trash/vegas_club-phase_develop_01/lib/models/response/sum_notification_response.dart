// To parse this JSON data, do
//
//     final sumNotifcationResponse = sumNotifcationResponseFromJson(jsonString);

import 'dart:convert';

class SumNotifcationResponse {
  SumNotifcationResponse({
    required this.total,
  });

  final int? total;

  SumNotifcationResponse copyWith({
    int? total,
  }) =>
      SumNotifcationResponse(
        total: total ?? this.total,
      );

  factory SumNotifcationResponse.fromRawJson(String str) =>
      SumNotifcationResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SumNotifcationResponse.fromJson(Map<String, dynamic> json) =>
      SumNotifcationResponse(
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
      };
}
