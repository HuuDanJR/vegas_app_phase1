// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jackpot_history.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JackpotHistory _$JackpotHistoryFromJson(Map<String, dynamic> json) =>
    JackpotHistory(
      date: json['DATE'] as String?,
      mcNo: json['MC NO.'] as int?,
      jackpot: json['JACKPOT'] as String?,
      mcName: json['MC NAME'] as String?,
      amount: json['AMOUNT'] as String?,
    );

Map<String, dynamic> _$JackpotHistoryToJson(JackpotHistory instance) =>
    <String, dynamic>{
      'DATE': instance.date,
      'MC NO.': instance.mcNo,
      'JACKPOT': instance.jackpot,
      'MC NAME': instance.mcName,
      'AMOUNT': instance.amount,
    };
