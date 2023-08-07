// To parse this JSON data, do
//
//     final systemStoreModel = systemStoreModelFromJson(jsonString);

import 'dart:convert';

SystemStoreModel systemStoreModelFromJson(String str) =>
    SystemStoreModel.fromJson(json.decode(str));

String systemStoreModelToJson(SystemStoreModel data) =>
    json.encode(data.toJson());

class SystemStoreModel {
  SystemStoreModel({
    this.urlAndroid,
    this.urlApple,
    this.maintain,
    this.canUpdate,
  });

  String? urlAndroid;
  String? urlApple;
  bool? maintain;
  bool? canUpdate;

  SystemStoreModel copyWith({
    String? urlAndroid,
    String? urlApple,
    bool? maintain,
    bool? canUpdate,
  }) =>
      SystemStoreModel(
        urlAndroid: urlAndroid ?? this.urlAndroid,
        urlApple: urlApple ?? this.urlApple,
        maintain: maintain ?? this.maintain,
        canUpdate: canUpdate ?? this.canUpdate,
      );

  factory SystemStoreModel.fromJson(Map<String, dynamic> json) =>
      SystemStoreModel(
        urlAndroid: json["url_android"],
        urlApple: json["url_apple"],
        maintain: json["maintain"],
        canUpdate: json["can_update"],
      );

  Map<String, dynamic> toJson() => {
        "url_android": urlAndroid,
        "url_apple": urlApple,
        "maintain": maintain,
        "can_update": canUpdate,
      };
}
