// To parse this JSON data, do
//
//     final cartResponse = cartResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cart_response.g.dart';

CartResponse cartResponseFromJson(String str) =>
    CartResponse.fromJson(json.decode(str));

String cartResponseToJson(CartResponse data) => json.encode(data.toJson());

@JsonSerializable()
class CartResponse {
  CartResponse({
    this.id,
    this.customerId,
    this.productId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  CartResponse copyWith({
    int? id,
    int? customerId,
    int? productId,
    int? quantity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CartResponse(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory CartResponse.fromJson(Map<String, dynamic> json) =>
      _$CartResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartResponseToJson(this);
}
