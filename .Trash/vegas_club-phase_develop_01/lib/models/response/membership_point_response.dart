// To parse this JSON data, do
//
//     final memberShipPointResponse = memberShipPointResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
part 'membership_point_response.g.dart';

MemberShipPointResponse memberShipPointResponseFromJson(String str) =>
    MemberShipPointResponse.fromJson(json.decode(str));

String memberShipPointResponseToJson(MemberShipPointResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class MemberShipPointResponse {
  MemberShipPointResponse({
    this.loyaltyPoint,
    this.loyaltyPointNext1,
    this.loyaltyPointSubNext1,
    this.loyaltyPointNext2,
    this.loyaltyPointSubNext2,
    this.loyaltyPointWeekly,
    this.loyaltyPointWeeklyRange,
    this.loyaltyPointWeeklyNextDraw,
    this.wallet,
    this.fortuneCredit,
    this.creditPoint,
    this.loyaltyPointCurrent,
    this.loyaltyPointMonth,
    this.loyaltyPointTodayRltb,
    this.loyaltyPointTodaySlot,
    this.framePoint,
    this.frameEndDate,
    this.frameStartDate,
    this.loyaltyPointToday,
  });

  @JsonKey(name: "loyalty_point")
  int? loyaltyPoint;
  @JsonKey(name: "loyalty_point_next_1")
  int? loyaltyPointNext1;
  @JsonKey(name: "loyalty_point_sub_next_1")
  String? loyaltyPointSubNext1;
  @JsonKey(name: "loyalty_point_next_2")
  int? loyaltyPointNext2;
  @JsonKey(name: "loyalty_point_sub_next_2")
  String? loyaltyPointSubNext2;
  @JsonKey(name: "loyalty_point_weekly")
  int? loyaltyPointWeekly;
  @JsonKey(name: "loyalty_point_weekly_range")
  String? loyaltyPointWeeklyRange;
  @JsonKey(name: "loyalty_point_weekly_next_draw")
  int? loyaltyPointWeeklyNextDraw;
  @JsonKey(name: "wallet")
  double? wallet;
  @JsonKey(name: "fortune_credit")
  double? fortuneCredit;
  @JsonKey(name: "credit_point")
  int? creditPoint;
  @JsonKey(name: "loyalty_point_current")
  int? loyaltyPointCurrent;
  @JsonKey(name: "loyalty_point_today")
  int? loyaltyPointToday;
  @JsonKey(name: "loyalty_point_month")
  int? loyaltyPointMonth;
  @JsonKey(name: "loyalty_point_today_slot")
  int? loyaltyPointTodaySlot;
  @JsonKey(name: "loyalty_point_today_rltb")
  int? loyaltyPointTodayRltb;
  @JsonKey(name: "frame_point")
  String? framePoint;
  @JsonKey(name: "frame_start_date")
  String? frameStartDate;
  @JsonKey(name: "frame_end_date")
  String? frameEndDate;

  MemberShipPointResponse copyWith({
    int? loyaltyPoint,
    int? loyaltyPointNext1,
    String? loyaltyPointSubNext1,
    int? loyaltyPointNext2,
    String? loyaltyPointSubNext2,
    int? loyaltyPointWeekly,
    String? loyaltyPointWeeklyRange,
    int? loyaltyPointWeeklyNextDraw,
    double? wallet,
    double? fortuneCredit,
    int? creditPoint,
    int? loyaltyPointCurrent,
    int? loyaltyPointMonth,
    int? loyaltyPointTodaySlot,
    int? loyaltyPointTodayRltb,
    String? framePoint,
    String? frameStartDate,
    String? frameEndDate,
    int? loyaltyPointToday,
  }) =>
      MemberShipPointResponse(
          loyaltyPoint: loyaltyPoint ?? this.loyaltyPoint,
          loyaltyPointNext1: loyaltyPointNext1 ?? this.loyaltyPointNext1,
          loyaltyPointSubNext1:
              loyaltyPointSubNext1 ?? this.loyaltyPointSubNext1,
          loyaltyPointNext2: loyaltyPointNext2 ?? this.loyaltyPointNext2,
          loyaltyPointSubNext2:
              loyaltyPointSubNext2 ?? this.loyaltyPointSubNext2,
          loyaltyPointWeekly: loyaltyPointWeekly ?? this.loyaltyPointWeekly,
          loyaltyPointWeeklyRange:
              loyaltyPointWeeklyRange ?? this.loyaltyPointWeeklyRange,
          loyaltyPointWeeklyNextDraw:
              loyaltyPointWeeklyNextDraw ?? this.loyaltyPointWeeklyNextDraw,
          wallet: wallet ?? this.wallet,
          fortuneCredit: fortuneCredit ?? this.fortuneCredit,
          creditPoint: creditPoint ?? this.creditPoint,
          loyaltyPointCurrent: loyaltyPointCurrent ?? this.loyaltyPointCurrent,
          loyaltyPointMonth: loyaltyPointMonth ?? this.loyaltyPointMonth,
          loyaltyPointTodaySlot:
              loyaltyPointTodaySlot ?? this.loyaltyPointTodaySlot,
          loyaltyPointTodayRltb:
              loyaltyPointTodayRltb ?? this.loyaltyPointTodayRltb,
          framePoint: framePoint ?? this.framePoint,
          frameStartDate: frameStartDate ?? this.frameStartDate,
          frameEndDate: frameEndDate ?? this.frameEndDate,
          loyaltyPointToday: loyaltyPointToday ?? this.loyaltyPointToday);

  factory MemberShipPointResponse.fromJson(Map<String, dynamic> json) =>
      _$MemberShipPointResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MemberShipPointResponseToJson(this);
}
