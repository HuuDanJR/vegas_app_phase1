// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartRequest _$CartRequestFromJson(Map<String, dynamic> json) => CartRequest(
      customerId: json['customer_id'] as int?,
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
    );

Map<String, dynamic> _$CartRequestToJson(CartRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('customer_id', instance.customerId);
  writeNotNull('product_id', instance.productId);
  writeNotNull('quantity', instance.quantity);
  return val;
}
