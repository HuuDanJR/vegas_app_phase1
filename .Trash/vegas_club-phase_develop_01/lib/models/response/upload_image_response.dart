// To parse this JSON data, do
//
//     final uploadImageResponse = uploadImageResponseFromJson(jsonString);

import 'dart:convert';

UploadImageResponse uploadImageResponseFromJson(String str) =>
    UploadImageResponse.fromJson(json.decode(str));

String uploadImageResponseToJson(UploadImageResponse data) =>
    json.encode(data.toJson());

class UploadImageResponse {
  UploadImageResponse({
    this.id,
    this.name,
    this.file,
    this.fileHash,
    this.category,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  FileClass? file;
  String? fileHash;
  int? category;
  DateTime? createdAt;
  DateTime? updatedAt;

  UploadImageResponse copyWith({
    int? id,
    String? name,
    FileClass? file,
    String? fileHash,
    int? category,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      UploadImageResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        file: file ?? this.file,
        fileHash: fileHash ?? this.fileHash,
        category: category ?? this.category,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) =>
      UploadImageResponse(
        id: json["id"],
        name: json["name"],
        file: FileClass.fromJson(json["file"]),
        fileHash: json["file_hash"],
        category: json["category"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "file": file!.toJson(),
        "file_hash": fileHash,
        "category": category,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class FileClass {
  FileClass({
    this.url,
    this.medium,
    this.thumb,
  });

  String? url;
  Medium? medium;
  Medium? thumb;

  FileClass copyWith({
    String? url,
    Medium? medium,
    Medium? thumb,
  }) =>
      FileClass(
        url: url ?? this.url,
        medium: medium ?? this.medium,
        thumb: thumb ?? this.thumb,
      );

  factory FileClass.fromJson(Map<String, dynamic> json) => FileClass(
        url: json["url"],
        medium: Medium.fromJson(json["medium"]),
        thumb: Medium.fromJson(json["thumb"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "medium": medium!.toJson(),
        "thumb": thumb!.toJson(),
      };
}

class Medium {
  Medium({
    this.url,
  });

  String? url;

  Medium copyWith({
    String? url,
  }) =>
      Medium(
        url: url ?? this.url,
      );

  factory Medium.fromJson(Map<String, dynamic> json) => Medium(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
