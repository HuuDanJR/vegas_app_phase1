// To parse this JSON data, do
//
//     final cartRequest = cartRequestFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'cart_request.g.dart';

CartRequest cartRequestFromJson(String str) =>
    CartRequest.fromJson(json.decode(str));

String cartRequestToJson(CartRequest data) => json.encode(data.toJson());

@JsonSerializable(includeIfNull: false)
class CartRequest {
  CartRequest({
    this.customerId,
    this.productId,
    this.quantity,
  });

  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "quantity")
  int? quantity;

  CartRequest copyWith({
    int? customerId,
    int? productId,
    int? quantity,
  }) =>
      CartRequest(
        customerId: customerId ?? this.customerId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
      );

  factory CartRequest.fromJson(Map<String, dynamic> json) =>
      _$CartRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CartRequestToJson(this);
}
