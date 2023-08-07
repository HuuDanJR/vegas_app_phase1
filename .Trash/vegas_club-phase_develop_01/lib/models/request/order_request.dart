import 'package:json_annotation/json_annotation.dart';

part 'order_request.g.dart';

@JsonSerializable(includeIfNull: false)
class OrderRequest {
  @JsonKey(name: "customer_id")
  final int? customerId;

  @JsonKey(name: "carts")
  final List<ListOrderRequest>? listIdCart;

  @JsonKey(name: "status")
  final int? status;

  OrderRequest({this.customerId, this.listIdCart, this.status});

  factory OrderRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRequestToJson(this);
}

@JsonSerializable()
class ListOrderRequest {
  @JsonKey(name: "id")
  final int? id;

  ListOrderRequest(this.id);

  factory ListOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$ListOrderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ListOrderRequestToJson(this);
}
