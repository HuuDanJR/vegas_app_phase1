// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_voucher_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyVoucherResponse _$MyVoucherResponseFromJson(Map<String, dynamic> json) =>
    MyVoucherResponse(
      displayName: json['display_name'] as String?,
      isValid: json['is_valid'] as bool?,
      value: json['value'] as String?,
      voucherId: json['voucher_id'] as String?,
      voucherType: json['voucher_type'] as String?,
    );

Map<String, dynamic> _$MyVoucherResponseToJson(MyVoucherResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('display_name', instance.displayName);
  writeNotNull('is_valid', instance.isValid);
  writeNotNull('value', instance.value);
  writeNotNull('voucher_id', instance.voucherId);
  writeNotNull('voucher_type', instance.voucherType);
  return val;
}
