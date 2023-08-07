// To parse this JSON data, do
//
//     final voucherResponse = voucherResponseFromJson(jsonString);

import 'dart:convert';

VoucherResponse voucherResponseFromJson(String str) =>
    VoucherResponse.fromJson(json.decode(str));

String voucherResponseToJson(VoucherResponse data) =>
    json.encode(data.toJson());

class VoucherResponse {
  VoucherResponse({
    this.voucherName,
    this.voucherType,
    this.messages,
    this.voucherStatus,
  });

  String? voucherName;
  String? voucherType;
  String? messages;
  String? voucherStatus;

  VoucherResponse copyWith({
    String? voucherName,
    String? voucherType,
    String? messages,
    String? voucherStatus,
  }) =>
      VoucherResponse(
        voucherName: voucherName ?? this.voucherName,
        voucherType: voucherType ?? this.voucherType,
        messages: messages ?? this.messages,
        voucherStatus: voucherStatus ?? this.voucherStatus,
      );

  factory VoucherResponse.fromJson(Map<String, dynamic> json) =>
      VoucherResponse(
        voucherName: json["voucher_name"],
        voucherType: json["voucher_type"],
        messages: json["messages"],
        voucherStatus: json["voucher_status"],
      );

  Map<String, dynamic> toJson() => {
        "voucher_name": voucherName,
        "voucher_type": voucherType,
        "messages": messages,
        "voucher_status": voucherStatus,
      };
}
