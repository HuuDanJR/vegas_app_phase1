// To parse this JSON data, do
//
//     final deviceResponse = deviceResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'device_response.g.dart';

DeviceResponse deviceResponseFromJson(String str) =>
    DeviceResponse.fromJson(json.decode(str));

String deviceResponseToJson(DeviceResponse data) => json.encode(data.toJson());

@JsonSerializable()
class DeviceResponse {
  DeviceResponse({
    this.id,
    this.token,
    this.deviceType,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "token")
  String? token;
  @JsonKey(name: "device_type")
  String? deviceType;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  DeviceResponse copyWith({
    int? id,
    String? token,
    String? deviceType,
    int? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      DeviceResponse(
        id: id ?? this.id,
        token: token ?? this.token,
        deviceType: deviceType ?? this.deviceType,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory DeviceResponse.fromJson(Map<String, dynamic> json) => DeviceResponse(
        id: json["id"],
        token: json["token"],
        deviceType: json["device_type"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "token": token,
        "device_type": deviceType,
        "user_id": userId,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
