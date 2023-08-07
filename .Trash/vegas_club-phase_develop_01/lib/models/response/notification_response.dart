// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'notification_response.g.dart';

List<NotificationResponse> notificationResponseFromJson(String str) =>
    List<NotificationResponse>.from(
        json.decode(str).map((x) => NotificationResponse.fromJson(x)));

String notificationResponseToJson(List<NotificationResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(includeIfNull: false)
class NotificationResponse {
  NotificationResponse({
    this.id,
    this.userId,
    this.sourceId,
    this.sourceType,
    this.notificationType,
    this.content,
    this.createdAt,
    this.statusType,
    this.byStatus,
    this.isRead,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "user_id")
  int? userId;
  @JsonKey(name: "source_id")
  int? sourceId;
  @JsonKey(name: "source_type")
  String? sourceType;
  @JsonKey(name: "notification_type")
  int? notificationType;
  @JsonKey(name: "content")
  String? content;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "status_type")
  int? statusType;
  @JsonKey(name: "by_status")
  int? byStatus;
  @JsonKey(name: "is_read")
  bool? isRead;

  NotificationResponse copyWith({
    int? id,
    int? userId,
    int? sourceId,
    String? sourceType,
    int? notificationType,
    String? content,
    DateTime? createdAt,
    int? statusType,
    int? byStatus,
    bool? isRead,
  }) =>
      NotificationResponse(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        sourceId: sourceId ?? this.sourceId,
        sourceType: sourceType ?? this.sourceType,
        notificationType: notificationType ?? this.notificationType,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        statusType: statusType ?? this.statusType,
        byStatus: byStatus ?? this.byStatus,
        isRead: isRead ?? this.isRead,
      );

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
