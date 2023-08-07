// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromJson(jsonString);


import 'package:json_annotation/json_annotation.dart';
part 'order_response.g.dart';

@JsonSerializable()
class OrderResponse {
  OrderResponse({
    this.id,
    this.customerId,
    this.total,
    this.status,
    this.createdAt,
    this.updatedAt,
  });
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "customer_id")
  int? customerId;
  @JsonKey(name: "total")
  int? total;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  OrderResponse copyWith({
    int? id,
    int? customerId,
    int? total,
    int? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      OrderResponse(
        id: id ?? this.id,
        customerId: customerId ?? this.customerId,
        total: total ?? this.total,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory OrderResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderResponseToJson(this);
}
