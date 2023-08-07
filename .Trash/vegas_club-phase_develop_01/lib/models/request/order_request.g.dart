// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) => OrderRequest(
      customerId: json['customer_id'] as int?,
      listIdCart: (json['carts'] as List<dynamic>?)
          ?.map((e) => ListOrderRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as int?,
    );

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('customer_id', instance.customerId);
  writeNotNull('carts', instance.listIdCart);
  writeNotNull('status', instance.status);
  return val;
}

ListOrderRequest _$ListOrderRequestFromJson(Map<String, dynamic> json) =>
    ListOrderRequest(
      json['id'] as int?,
    );

Map<String, dynamic> _$ListOrderRequestToJson(ListOrderRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
