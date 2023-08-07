// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'machine_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MachineResponse _$MachineResponseFromJson(Map<String, dynamic> json) =>
    MachineResponse(
      id: json['id'] as int?,
      customerId: json['customer_id'] as int?,
      machineNumber: json['machine_number'] as int?,
      machineName: json['machine_name'] as String?,
      startedAt: json['started_at'] == null
          ? null
          : DateTime.parse(json['started_at'] as String),
      endedAt: json['ended_at'] == null
          ? null
          : DateTime.parse(json['ended_at'] as String),
      customerNote: json['customer_note'] as String?,
      bookingType: json['booking_type'] as int?,
      internalNote: json['internal_note'] as String?,
      status: json['status'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      customer: json['customer'] == null
          ? null
          : CustomerResponse.fromJson(json['customer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MachineResponseToJson(MachineResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customer_id': instance.customerId,
      'machine_number': instance.machineNumber,
      'machine_name': instance.machineName,
      'started_at': instance.startedAt?.toIso8601String(),
      'ended_at': instance.endedAt?.toIso8601String(),
      'customer_note': instance.customerNote,
      'booking_type': instance.bookingType,
      'internal_note': instance.internalNote,
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'customer': instance.customer,
    };
