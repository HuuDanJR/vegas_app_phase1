// To parse this JSON data, do
//
//     final roulette = rouletteFromJson(jsonString);

import 'dart:convert';

List<RouletteResponse> rouletteFromJson(String str) =>
    List<RouletteResponse>.from(
        json.decode(str).map((x) => RouletteResponse.fromJson(x)));

String rouletteToJson(List<RouletteResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RouletteResponse {
  RouletteResponse({
    this.id,
    this.name,
    this.description,
    this.streamingUrl,
    this.publish,
  });

  int? id;
  String? name;
  String? description;
  String? streamingUrl;
  bool? publish;

  RouletteResponse copyWith({
    int? id,
    String? name,
    String? description,
    String? streamingUrl,
    bool? publish,
  }) =>
      RouletteResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        streamingUrl: streamingUrl ?? this.streamingUrl,
        publish: publish ?? this.publish,
      );

  factory RouletteResponse.fromJson(Map<String, dynamic> json) =>
      RouletteResponse(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        streamingUrl: json["streaming_url"],
        publish: json["publish"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "streaming_url": streamingUrl,
        "publish": publish,
      };
}
