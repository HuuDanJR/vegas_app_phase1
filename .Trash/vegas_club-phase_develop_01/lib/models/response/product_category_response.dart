// To parse this JSON data, do
//
//     final productCategoryResponse = productCategoryResponseFromJson(jsonString);

import 'dart:convert';

ProductCategoryResponse productCategoryResponseFromJson(String str) =>
    ProductCategoryResponse.fromJson(json.decode(str));

String productCategoryResponseToJson(ProductCategoryResponse data) =>
    json.encode(data.toJson());

class ProductCategoryResponse {
  ProductCategoryResponse({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  ProductCategoryResponse copyWith({
    int? id,
    String? name,
  }) =>
      ProductCategoryResponse(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory ProductCategoryResponse.fromJson(Map<String, dynamic> json) =>
      ProductCategoryResponse(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
