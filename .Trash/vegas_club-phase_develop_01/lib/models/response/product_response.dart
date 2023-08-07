// To parse this JSON data, do
//
//     final productResponse = productResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'product_response.g.dart';

List<ProductResponse> productResponseFromJson(String str) =>
    List<ProductResponse>.from(
        json.decode(str).map((x) => ProductResponse.fromJson(x)));

String productResponseToJson(List<ProductResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(includeIfNull: false)
class ProductResponse {
  ProductResponse(
      {this.id,
      this.sku,
      this.qrcode,
      this.name,
      this.desc,
      this.basePrice,
      this.price,
      this.pointPrice,
      this.productType,
      this.attachmentId,
      this.productCategoryId,
      this.attachment,
      this.productCategory,
      this.quantity = 1});

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "qrcode")
  String? qrcode;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "desc")
  String? desc;
  @JsonKey(name: "base_price")
  int? basePrice;
  @JsonKey(name: "price")
  int? price;
  @JsonKey(name: "point_price")
  int? pointPrice;
  @JsonKey(name: "product_type")
  int? productType;
  @JsonKey(name: "attachment_id")
  int? attachmentId;
  @JsonKey(name: "product_category_id")
  int? productCategoryId;
  @JsonKey(name: "attachment")
  AttachmentProduct? attachment;
  @JsonKey(name: "product_category")
  ProductCategory? productCategory;
  int? quantity;
  ProductResponse copyWith({
    int? id,
    String? sku,
    String? qrcode,
    String? name,
    String? desc,
    int? basePrice,
    int? price,
    int? pointPrice,
    int? productType,
    int? attachmentId,
    int? productCategoryId,
    AttachmentProduct? attachment,
    ProductCategory? productCategory,
    int? quantity,
  }) =>
      ProductResponse(
        id: id ?? this.id,
        sku: sku ?? this.sku,
        qrcode: qrcode ?? this.qrcode,
        name: name ?? this.name,
        desc: desc ?? this.desc,
        basePrice: basePrice ?? this.basePrice,
        price: price ?? this.price,
        pointPrice: pointPrice ?? this.pointPrice,
        productType: productType ?? this.productType,
        attachmentId: attachmentId ?? this.attachmentId,
        productCategoryId: productCategoryId ?? this.productCategoryId,
        attachment: attachment ?? this.attachment,
        productCategory: productCategory ?? this.productCategory,
        quantity: quantity ?? this.quantity,
      );

  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductResponseToJson(this);
}

@JsonSerializable()
class AttachmentProduct {
  AttachmentProduct({
    this.id,
    this.name,
    this.category,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "category")
  int? category;

  AttachmentProduct copyWith({
    int? id,
    String? name,
    int? category,
  }) =>
      AttachmentProduct(
        id: id ?? this.id,
        name: name ?? this.name,
        category: category ?? this.category,
      );

  factory AttachmentProduct.fromJson(Map<String, dynamic> json) =>
      AttachmentProduct(
        id: json["id"],
        name: json["name"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
      };
}

@JsonSerializable()
class ProductCategory {
  ProductCategory({
    this.id,
    this.name,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  ProductCategory copyWith({
    int? id,
    String? name,
  }) =>
      ProductCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);
}
