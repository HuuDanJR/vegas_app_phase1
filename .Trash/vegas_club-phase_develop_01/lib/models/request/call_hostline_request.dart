// To parse this JSON data, do
//
//     final callHotLineRequest = callHotLineRequestFromJson(jsonString);

import 'dart:convert';

CallHotLineRequest callHotLineRequestFromJson(String str) =>
    CallHotLineRequest.fromJson(json.decode(str));

String callHotLineRequestToJson(CallHotLineRequest data) =>
    json.encode(data.toJson());

class CallHotLineRequest {
  CallHotLineRequest({
    this.officerId,
    this.customerId,
  });

  int? officerId;
  int? customerId;

  CallHotLineRequest copyWith({
    int? officerId,
    int? customerId,
  }) =>
      CallHotLineRequest(
        officerId: officerId ?? this.officerId,
        customerId: customerId ?? this.customerId,
      );

  factory CallHotLineRequest.fromJson(Map<String, dynamic> json) =>
      CallHotLineRequest(
        officerId: json["officer_id"],
        customerId: json["customer_id"],
      );

  Map<String, dynamic> toJson() => {
        "officer_id": officerId,
        "customer_id": customerId,
      };
}
