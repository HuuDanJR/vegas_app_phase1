// To parse this JSON data, do
//
//     final machinePlayResponse = machinePlayResponseFromJson(jsonString);

import 'dart:convert';

MachinePlayResponse machinePlayResponseFromJson(String str) =>
    MachinePlayResponse.fromJson(json.decode(str));

String machinePlayResponseToJson(MachinePlayResponse data) =>
    json.encode(data.toJson());

class MachinePlayResponse {
  MachinePlayResponse({
    this.machineNumber,
    this.machineName,
  });

  String? machineNumber;
  String? machineName;

  MachinePlayResponse copyWith({
    String? machineNumber,
    String? machineName,
  }) =>
      MachinePlayResponse(
        machineNumber: machineNumber ?? this.machineNumber,
        machineName: machineName ?? this.machineName,
      );

  factory MachinePlayResponse.fromJson(Map<String, dynamic> json) =>
      MachinePlayResponse(
        machineNumber: json["machine_number"],
        machineName: json["machine_name"],
      );

  Map<String, dynamic> toJson() => {
        "machine_number": machineNumber,
        "machine_name": machineName,
      };
}
