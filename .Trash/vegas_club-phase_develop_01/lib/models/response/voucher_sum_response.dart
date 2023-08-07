// To parse this JSON data, do
//
//     final voucherSumResponse = voucherSumResponseFromJson(jsonString);

import 'dart:convert';

class VoucherSumResponse {
  VoucherSumResponse({
    required this.totalVoucher,
  });

  final int? totalVoucher;

  VoucherSumResponse copyWith({
    int? totalVoucher,
  }) =>
      VoucherSumResponse(
        totalVoucher: totalVoucher ?? this.totalVoucher,
      );

  factory VoucherSumResponse.fromRawJson(String str) =>
      VoucherSumResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VoucherSumResponse.fromJson(Map<String, dynamic> json) =>
      VoucherSumResponse(
        totalVoucher: json["total_voucher"],
      );

  Map<String, dynamic> toJson() => {
        "total_voucher": totalVoucher,
      };
}
