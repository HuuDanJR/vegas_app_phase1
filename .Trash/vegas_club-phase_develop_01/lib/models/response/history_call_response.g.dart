// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_call_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryCallResponse _$HistoryCallResponseFromJson(Map<String, dynamic> json) =>
    HistoryCallResponse(
      id: json['id'] as int?,
      officerId: json['officer_id'] as int?,
      customerId: json['customer_id'] as int?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      officer: json['officer'] == null
          ? null
          : OfficerResponse.fromJson(json['officer'] as Map<String, dynamic>),
    )..formatDate = json['formatDate'] == null
        ? null
        : DateTime.parse(json['formatDate'] as String);

Map<String, dynamic> _$HistoryCallResponseToJson(HistoryCallResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('officer_id', instance.officerId);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('officer', instance.officer);
  writeNotNull('formatDate', instance.formatDate?.toIso8601String());
  return val;
}
