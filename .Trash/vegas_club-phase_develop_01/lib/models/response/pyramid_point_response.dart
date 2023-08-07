// To parse this JSON data, do
//
//     final pyramidPointResponse = pyramidPointResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'pyramid_point_response.g.dart';

List<PyramidPointResponse> pyramidPointResponseFromJson(String str) =>
    List<PyramidPointResponse>.from(
        json.decode(str).map((x) => PyramidPointResponse.fromJson(x)));

String pyramidPointResponseToJson(List<PyramidPointResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class PyramidPointResponse {
  PyramidPointResponse({
    this.id,
    this.prize,
    this.minPoint,
    this.maxPoint,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "prize")
  String? prize;
  @JsonKey(name: "min_point")
  int? minPoint;
  @JsonKey(name: "max_point")
  int? maxPoint;

  PyramidPointResponse copyWith({
    int? id,
    String? prize,
    int? minPoint,
    int? maxPoint,
  }) =>
      PyramidPointResponse(
        id: id ?? this.id,
        prize: prize ?? this.prize,
        minPoint: minPoint ?? this.minPoint,
        maxPoint: maxPoint ?? this.maxPoint,
      );

  factory PyramidPointResponse.fromJson(Map<String, dynamic> json) =>
      _$PyramidPointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PyramidPointResponseToJson(this);
}
