// To parse this JSON data, do
//
//     final pyramidPoin = pyramidPoinFromJson(jsonString);

import 'dart:convert';


List<PyramidPoint> pyramidPoinFromJson(String str) => List<PyramidPoint>.from(
    json.decode(str).map((x) => PyramidPoint.fromJson(x)));

String pyramidPoinToJson(List<PyramidPoint> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PyramidPoint {
  PyramidPoint({
    this.price,
    this.pts,
  });

  final String? price;
  final List<String>? pts;

  PyramidPoint copyWith({
    String? price,
    List<String>? pts,
  }) =>
      PyramidPoint(
        price: price ?? this.price,
        pts: pts ?? this.pts,
      );

  factory PyramidPoint.fromJson(Map<String, dynamic> json) => PyramidPoint(
        price: json["price"],
        pts: List<String>.from(json["pts"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "pts": List<dynamic>.from(pts!.map((x) => x)),
      };
}
