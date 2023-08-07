// To parse this JSON data, do
//
//     final notificationLocalResponse = notificationLocalResponseFromJson(jsonString);

import 'dart:convert';

class NotificationLocalResponse {
  NotificationLocalResponse({
    required this.id,
    required this.content,
    required this.title,
  });

  final int? id;
  final String? title;
  final String? content;

  NotificationLocalResponse copyWith({
    int? id,
    String? content,
  }) =>
      NotificationLocalResponse(
        title: title ?? title,
        id: id ?? this.id,
        content: content ?? this.content,
      );

  factory NotificationLocalResponse.fromRawJson(String str) =>
      NotificationLocalResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationLocalResponse.fromJson(Map<String, dynamic> json) =>
      NotificationLocalResponse(
        title: json["title"],
        id: json["id"],
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
      };
}

class NotificationPayloadResponse {
  NotificationPayloadResponse({
    required this.type,
    required this.message,
    required this.objectId,
  });

  final String? type;
  final String? message;
  final String? objectId;

  NotificationPayloadResponse copyWith({
    String? type,
    String? message,
    String? objectId,
  }) =>
      NotificationPayloadResponse(
        type: type ?? this.type,
        message: message ?? this.message,
        objectId: objectId ?? this.objectId,
      );

  factory NotificationPayloadResponse.fromRawJson(String str) =>
      NotificationPayloadResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NotificationPayloadResponse.fromJson(Map<String, dynamic> json) =>
      NotificationPayloadResponse(
        type: json["type"],
        message: json["message"],
        objectId: json["object_id"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "object_id": objectId,
      };
}
