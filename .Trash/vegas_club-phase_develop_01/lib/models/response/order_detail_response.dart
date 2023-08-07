// To parse this JSON data, do
//
//     final orderDetailResponse = orderDetailResponseFromJson(jsonString);

import 'dart:convert';

OrderDetailResponse orderDetailResponseFromJson(String str) =>
    OrderDetailResponse.fromJson(json.decode(str));

String orderDetailResponseToJson(OrderDetailResponse data) =>
    json.encode(data.toJson());

class OrderDetailResponse {
  OrderDetailResponse({
    this.id,
    this.customerId,
    this.total,
    this.status,
    this.internalNote,
    this.orderProducts,
    this.products,
  });

  int? id;
  int? customerId;
  int? total;
  int? status;
  String? internalNote;
  List<OrderProduct>? orderProducts;
  List<Product>? products;

  OrderDetailResponse copyWith({
    int? id,
    int? customerId,
    int? total,
    int? status,
    String? internalNote,
    List<OrderProduct>? orderProducts,
    List<Product>? products,
  }) =>
      OrderDetailResponse(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        total: total ?? this.total,
        status: status ?? this.status,
        internalNote: internalNote ?? this.internalNote,
        orderProducts: orderProducts ?? this.orderProducts,
        products: products ?? this.products,
      );

  factory OrderDetailResponse.fromJson(Map<String, dynamic> json) =>
      OrderDetailResponse(
        id: json["id"],
        customerId: json["customer_id"],
        total: json["total"],
        status: json["status"],
        internalNote: json["internal_note"],
        orderProducts: List<OrderProduct>.from(
            json["order_products"].map((x) => OrderProduct.fromJson(x))),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_id": customerId,
        "total": total,
        "status": status,
        "internal_note": internalNote,
        "order_products":
            List<dynamic>.from(orderProducts!.map((x) => x.toJson())),
        "products": List<dynamic>.from(products!.map((x) => x.toJson())),
      };
}

class OrderProduct {
  OrderProduct({
    this.id,
    this.productId,
    this.quantity,
    this.unitPrice,
    this.subTotal,
  });

  int? id;
  int? productId;
  int? quantity;
  int? unitPrice;
  int? subTotal;

  OrderProduct copyWith({
    int? id,
    int? productId,
    int? quantity,
    int? unitPrice,
    int? subTotal,
  }) =>
      OrderProduct(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        subTotal: subTotal ?? this.subTotal,
      );

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
        id: json["id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        unitPrice: json["unit_price"],
        subTotal: json["sub_total"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "quantity": quantity,
        "unit_price": unitPrice,
        "sub_total": subTotal,
      };
}

class Product {
  Product({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  Product copyWith({
    int? id,
    String? name,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
