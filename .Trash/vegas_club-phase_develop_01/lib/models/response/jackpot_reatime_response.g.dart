// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jackpot_reatime_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JackpotRealtimeResponse _$JackpotRealtimeResponseFromJson(
        Map<String, dynamic> json) =>
    JackpotRealtimeResponse(
      lastUpdate: json['last_update'] == null
          ? null
          : DateTime.parse(json['last_update'] as String),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$JackpotRealtimeResponseToJson(
        JackpotRealtimeResponse instance) =>
    <String, dynamic>{
      'last_update': instance.lastUpdate?.toIso8601String(),
      'data': instance.data,
    };

Datum _$DatumFromJson(Map<String, dynamic> json) => Datum(
      name: json['name'] as String?,
      value: json['value'],
      max: json['max'] as String?,
      min: json['min'] as String?,
    );

Map<String, dynamic> _$DatumToJson(Datum instance) => <String, dynamic>{
      'name': instance.name,
      'value': instance.value,
      'max': instance.max,
      'min': instance.min,
    };
