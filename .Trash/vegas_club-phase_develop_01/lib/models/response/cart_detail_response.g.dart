// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartDetailResponse _$CartDetailResponseFromJson(Map<String, dynamic> json) =>
    CartDetailResponse(
      id: json['id'] as int?,
      customerId: json['customer_id'] as int?,
      productId: json['product_id'] as int?,
      quantity: json['quantity'] as int?,
      product: json['product'] == null
          ? null
          : ProductResponse.fromJson(json['product'] as Map<String, dynamic>),
      isChecked: json['isChecked'] as bool? ?? true,
      totalPoint: json['totalPoint'] as int?,
    );

Map<String, dynamic> _$CartDetailResponseToJson(CartDetailResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('customer_id', instance.customerId);
  writeNotNull('product_id', instance.productId);
  writeNotNull('quantity', instance.quantity);
  writeNotNull('product', instance.product);
  writeNotNull('isChecked', instance.isChecked);
  writeNotNull('totalPoint', instance.totalPoint);
  return val;
}
