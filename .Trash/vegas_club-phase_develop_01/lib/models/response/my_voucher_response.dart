// To parse this JSON data, do
//
//     final myVoucherResponse = myVoucherResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'my_voucher_response.g.dart';

List<MyVoucherResponse> myVoucherResponseFromJson(String str) =>
    List<MyVoucherResponse>.from(
        json.decode(str).map((x) => MyVoucherResponse.fromJson(x)));

String myVoucherResponseToJson(List<MyVoucherResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(includeIfNull: false)
class MyVoucherResponse {
  MyVoucherResponse({
    this.displayName,
    this.isValid,
    this.value,
    this.voucherId,
    this.voucherType,
  });

  @JsonKey(name: "display_name")
  String? displayName;
  @JsonKey(name: "is_valid")
  bool? isValid;
  @JsonKey(name: "value")
  String? value;
  @JsonKey(name: "voucher_id")
  String? voucherId;
  @JsonKey(name: "voucher_type")
  String? voucherType;

  MyVoucherResponse copyWith({
    String? displayName,
    bool? isValid,
    String? value,
    String? voucherId,
    String? voucherType,
  }) =>
      MyVoucherResponse(
        displayName: displayName ?? this.displayName,
        isValid: isValid ?? this.isValid,
        value: value ?? this.value,
        voucherId: voucherId ?? this.voucherId,
        voucherType: voucherType ?? this.voucherType,
      );

  factory MyVoucherResponse.fromJson(Map<String, dynamic> json) =>
      _$MyVoucherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MyVoucherResponseToJson(this);
}
