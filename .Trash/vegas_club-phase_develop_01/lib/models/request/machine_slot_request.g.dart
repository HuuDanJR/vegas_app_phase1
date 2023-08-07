// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_slot_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineSlotRequest _$MachineSlotRequestFromJson(Map<String, dynamic> json) =>
    MachineSlotRequest(
      customerId: json['customer_id'] as int?,
      machineNumber: json['machine_number'] as int?,
      machineName: json['machine_name'] as String?,
      startedAt: json['started_at'] as String?,
      endedAt: json['ended_at'] as String?,
      customerNote: json['customer_note'] as String?,
    );

Map<String, dynamic> _$MachineSlotRequestToJson(MachineSlotRequest instance) =>
    <String, dynamic>{
      'customer_id': instance.customerId,
      'machine_number': instance.machineNumber,
      'machine_name': instance.machineName,
      'started_at': instance.startedAt,
      'ended_at': instance.endedAt,
      'customer_note': instance.customerNote,
    };
