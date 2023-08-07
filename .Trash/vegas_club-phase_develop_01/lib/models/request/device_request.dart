// To parse this JSON data, do
//
//     final deviceRequest = deviceRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'device_request.g.dart';

DeviceRequest deviceRequestFromJson(String str) =>
    DeviceRequest.fromJson(json.decode(str));

String deviceRequestToJson(DeviceRequest data) => json.encode(data.toJson());

@JsonSerializable(includeIfNull: false)
class DeviceRequest {
  DeviceRequest({
    this.userId,
    this.token,
    this.deviceType,
    this.timeExpired,
  });

  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "device_type")
  String? deviceType;
  @JsonKey(name: "time_expired")
  String? timeExpired;

  DeviceRequest copyWith({
    int? userId,
    String? token,
    String? deviceType,
    String? timeExpired,
  }) =>
      DeviceRequest(
          userId: userId ?? this.userId,
          token: token ?? this.token,
          deviceType: deviceType ?? this.deviceType,
          timeExpired: timeExpired ?? this.timeExpired);

  factory DeviceRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DeviceRequestToJson(this);
}
