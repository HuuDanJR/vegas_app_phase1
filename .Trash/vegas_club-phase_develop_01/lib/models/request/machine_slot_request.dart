// To parse this JSON data, do
//
//     final machineSlotRequest = machineSlotRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'machine_slot_request.g.dart';

MachineSlotRequest machineSlotRequestFromJson(String str) =>
    MachineSlotRequest.fromJson(json.decode(str));

String machineSlotRequestToJson(MachineSlotRequest data) =>
    json.encode(data.toJson());

@JsonSerializable()
class MachineSlotRequest {
  MachineSlotRequest({
    this.customerId,
    this.machineNumber,
    this.machineName,
    this.startedAt,
    this.endedAt,
    this.customerNote,
  });

  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "machine_number")
  int? machineNumber;
  @JsonKey(name: "machine_name")
  String? machineName;
  @JsonKey(name: "started_at")
  String? startedAt;
  @JsonKey(name: "ended_at")
  String? endedAt;
  @JsonKey(name: "customer_note")
  String? customerNote;

  MachineSlotRequest copyWith({
    int? customerId,
    int? machineNumber,
    String? machineName,
    String? startedAt,
    String? endedAt,
    String? customerNote,
  }) =>
      MachineSlotRequest(
        customerId: customerId ?? this.customerId,
        machineNumber: machineNumber ?? this.machineNumber,
        machineName: machineName ?? this.machineName,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
        customerNote: customerNote ?? this.customerNote,
      );

  factory MachineSlotRequest.fromJson(Map<String, dynamic> json) =>
      _$MachineSlotRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MachineSlotRequestToJson(this);
}
