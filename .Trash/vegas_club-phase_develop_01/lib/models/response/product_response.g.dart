// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductResponse _$ProductResponseFromJson(Map<String, dynamic> json) =>
    ProductResponse(
      id: json['id'] as int?,
      sku: json['sku'] as String?,
      qrcode: json['qrcode'] as String?,
      name: json['name'] as String?,
      desc: json['desc'] as String?,
      basePrice: json['base_price'] as int?,
      price: json['price'] as int?,
      pointPrice: json['point_price'] as int?,
      productType: json['product_type'] as int?,
      attachmentId: json['attachment_id'] as int?,
      productCategoryId: json['product_category_id'] as int?,
      attachment: json['attachment'] == null
          ? null
          : AttachmentProduct.fromJson(
              json['attachment'] as Map<String, dynamic>),
      productCategory: json['product_category'] == null
          ? null
          : ProductCategory.fromJson(
              json['product_category'] as Map<String, dynamic>),
      quantity: json['quantity'] as int? ?? 1,
    );

Map<String, dynamic> _$ProductResponseToJson(ProductResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('sku', instance.sku);
  writeNotNull('qrcode', instance.qrcode);
  writeNotNull('name', instance.name);
  writeNotNull('desc', instance.desc);
  writeNotNull('base_price', instance.basePrice);
  writeNotNull('price', instance.price);
  writeNotNull('point_price', instance.pointPrice);
  writeNotNull('product_type', instance.productType);
  writeNotNull('attachment_id', instance.attachmentId);
  writeNotNull('product_category_id', instance.productCategoryId);
  writeNotNull('attachment', instance.attachment);
  writeNotNull('product_category', instance.productCategory);
  writeNotNull('quantity', instance.quantity);
  return val;
}

AttachmentProduct _$AttachmentProductFromJson(Map<String, dynamic> json) =>
    AttachmentProduct(
      id: json['id'] as int?,
      name: json['name'] as String?,
      category: json['category'] as int?,
    );

Map<String, dynamic> _$AttachmentProductToJson(AttachmentProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
    };

ProductCategory _$ProductCategoryFromJson(Map<String, dynamic> json) =>
    ProductCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductCategoryToJson(ProductCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
