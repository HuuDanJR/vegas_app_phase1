// To parse this JSON data, do
//
//     final cartDetailResponse = cartDetailResponseFromJson(jsonString);


import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/models/response/product_response.dart';
part 'cart_detail_response.g.dart';

@JsonSerializable(includeIfNull: false)
class CartDetailResponse {
  CartDetailResponse(
      {this.id,
      this.customerId,
      this.productId,
      this.quantity,
      this.product,
      this.isChecked = true,
      this.totalPoint});

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "product_id")
  int? productId;
  @JsonKey(name: "quantity")
  int? quantity;
  @JsonKey(name: "product")
  ProductResponse? product;
  bool? isChecked;
  int? totalPoint;

  CartDetailResponse copyWith({
    int? id,
    int? customerId,
    int? productId,
    int? quantity,
    ProductResponse? product,
    bool? isChecked,
  }) =>
      CartDetailResponse(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        product: product ?? this.product,
        isChecked: isChecked ?? this.isChecked,
      );

  factory CartDetailResponse.fromJson(Map<String, dynamic> json) =>
      _$CartDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CartDetailResponseToJson(this);

  int getTotalPointPice() {
    return product!.pointPrice! * quantity!;
  }
}
