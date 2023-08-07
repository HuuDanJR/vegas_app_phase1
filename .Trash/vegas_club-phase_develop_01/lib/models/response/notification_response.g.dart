// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      sourceId: json['source_id'] as int?,
      sourceType: json['source_type'] as String?,
      notificationType: json['notification_type'] as int?,
      content: json['content'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      statusType: json['status_type'] as int?,
      byStatus: json['by_status'] as int?,
      isRead: json['is_read'] as bool?,
    );

Map<String, dynamic> _$NotificationResponseToJson(
    NotificationResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('user_id', instance.userId);
  writeNotNull('source_id', instance.sourceId);
  writeNotNull('source_type', instance.sourceType);
  writeNotNull('notification_type', instance.notificationType);
  writeNotNull('content', instance.content);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('status_type', instance.statusType);
  writeNotNull('by_status', instance.byStatus);
  writeNotNull('is_read', instance.isRead);
  return val;
}
