// To parse this JSON data, do
//
//     final slideLevelResponse = slideLevelResponseFromJson(jsonString);

import 'dart:convert';

List<SlideLevelResponse> slideLevelResponseFromJson(String str) =>
    List<SlideLevelResponse>.from(
        json.decode(str).map((x) => SlideLevelResponse.fromJson(x)));

String slideLevelResponseToJson(List<SlideLevelResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlideLevelResponse {
  SlideLevelResponse({
    this.id,
    this.name,
    this.index,
    this.attachmentId,
  });

  int? id;
  String? name;
  int? index;
  int? attachmentId;

  SlideLevelResponse copyWith({
    int? id,
    String? name,
    int? index,
    int? attachmentId,
  }) =>
      SlideLevelResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        index: index ?? this.index,
        attachmentId: attachmentId ?? this.attachmentId,
      );

  factory SlideLevelResponse.fromJson(Map<String, dynamic> json) =>
      SlideLevelResponse(
        id: json["id"],
        name: json["name"],
        index: json["index"],
        attachmentId: json["attachment_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "index": index,
        "attachment_id": attachmentId,
      };
}
