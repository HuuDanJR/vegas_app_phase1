// To parse this JSON data, do
//
//     final machineResponse = machineResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/models/response/customer_response.dart';
part 'machine_response.g.dart';

List<MachineResponse> machineResponseFromJson(String str) =>
    List<MachineResponse>.from(
        json.decode(str).map((x) => MachineResponse.fromJson(x)));

String machineResponseToJson(List<MachineResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class MachineResponse {
  MachineResponse({
    this.id,
    this.customerId,
    this.machineNumber,
    this.machineName,
    this.startedAt,
    this.endedAt,
    this.customerNote,
    this.bookingType,
    this.internalNote,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.customer,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "machine_number")
  int? machineNumber;
  @JsonKey(name: "machine_name")
  String? machineName;
  @JsonKey(name: "started_at")
  DateTime? startedAt;
  @JsonKey(name: "ended_at")
  DateTime? endedAt;
  @JsonKey(name: "customer_note")
  String? customerNote;
  @JsonKey(name: "booking_type")
  int? bookingType;
  @JsonKey(name: "internal_note")
  String? internalNote;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "customer")
  CustomerResponse? customer;

  MachineResponse copyWith({
    int? id,
    int? customerId,
    int? machineNumber,
    String? machineName,
    DateTime? startedAt,
    DateTime? endedAt,
    String? customerNote,
    int? bookingType,
    String? internalNote,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    CustomerResponse? customer,
  }) =>
      MachineResponse(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        machineNumber: machineNumber ?? this.machineNumber,
        machineName: machineName ?? this.machineName,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
        customerNote: customerNote ?? this.customerNote,
        bookingType: bookingType ?? this.bookingType,
        internalNote: internalNote ?? this.internalNote,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        customer: customer ?? this.customer,
      );

  factory MachineResponse.fromJson(Map<String, dynamic> json) =>
      _$MachineResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MachineResponseToJson(this);
}
