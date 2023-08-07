// To parse this JSON data, do
//
//     final historyResponse = historyResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/models/response/officer_response.dart';
part 'history_call_response.g.dart';

List<HistoryCallResponse> historyResponseFromJson(String str) =>
    List<HistoryCallResponse>.from(
        json.decode(str).map((x) => HistoryCallResponse.fromJson(x)));

String historyResponseToJson(List<HistoryCallResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(includeIfNull: false)
class HistoryCallResponse {
  HistoryCallResponse({
    this.id,
    this.officerId,
    this.customerId,
    this.createdAt,
    this.officer,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "officer_id")
  int? officerId;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "officer")
  OfficerResponse? officer;
  DateTime? formatDate;

  HistoryCallResponse copyWith({
    int? id,
    int? officerId,
    int? customerId,
    DateTime? createdAt,
    OfficerResponse? officer,
  }) =>
      HistoryCallResponse(
        id: id ?? this.id,
        officerId: officerId ?? this.officerId,
        customerId: customerId ?? this.customerId,
        createdAt: createdAt ?? this.createdAt,
        officer: officer ?? this.officer,
      );

  factory HistoryCallResponse.fromJson(Map<String, dynamic> json) =>
      _$HistoryCallResponseFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryCallResponseToJson(this);
}
