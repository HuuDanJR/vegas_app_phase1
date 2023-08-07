// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'membership_point_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MemberShipPointResponse _$MemberShipPointResponseFromJson(
        Map<String, dynamic> json) =>
    MemberShipPointResponse(
      loyaltyPoint: json['loyalty_point'] as int?,
      loyaltyPointNext1: json['loyalty_point_next_1'] as int?,
      loyaltyPointSubNext1: json['loyalty_point_sub_next_1'] as String?,
      loyaltyPointNext2: json['loyalty_point_next_2'] as int?,
      loyaltyPointSubNext2: json['loyalty_point_sub_next_2'] as String?,
      loyaltyPointWeekly: json['loyalty_point_weekly'] as int?,
      loyaltyPointWeeklyRange: json['loyalty_point_weekly_range'] as String?,
      loyaltyPointWeeklyNextDraw:
          json['loyalty_point_weekly_next_draw'] as int?,
      wallet: (json['wallet'] as num?)?.toDouble(),
      fortuneCredit: (json['fortune_credit'] as num?)?.toDouble(),
      creditPoint: json['credit_point'] as int?,
      loyaltyPointCurrent: json['loyalty_point_current'] as int?,
      loyaltyPointMonth: json['loyalty_point_month'] as int?,
      loyaltyPointTodayRltb: json['loyalty_point_today_rltb'] as int?,
      loyaltyPointTodaySlot: json['loyalty_point_today_slot'] as int?,
      framePoint: json['frame_point'] as String?,
      frameEndDate: json['frame_end_date'] as String?,
      frameStartDate: json['frame_start_date'] as String?,
      loyaltyPointToday: json['loyalty_point_today'] as int?,
    );

Map<String, dynamic> _$MemberShipPointResponseToJson(
        MemberShipPointResponse instance) =>
    <String, dynamic>{
      'loyalty_point': instance.loyaltyPoint,
      'loyalty_point_next_1': instance.loyaltyPointNext1,
      'loyalty_point_sub_next_1': instance.loyaltyPointSubNext1,
      'loyalty_point_next_2': instance.loyaltyPointNext2,
      'loyalty_point_sub_next_2': instance.loyaltyPointSubNext2,
      'loyalty_point_weekly': instance.loyaltyPointWeekly,
      'loyalty_point_weekly_range': instance.loyaltyPointWeeklyRange,
      'loyalty_point_weekly_next_draw': instance.loyaltyPointWeeklyNextDraw,
      'wallet': instance.wallet,
      'fortune_credit': instance.fortuneCredit,
      'credit_point': instance.creditPoint,
      'loyalty_point_current': instance.loyaltyPointCurrent,
      'loyalty_point_today': instance.loyaltyPointToday,
      'loyalty_point_month': instance.loyaltyPointMonth,
      'loyalty_point_today_slot': instance.loyaltyPointTodaySlot,
      'loyalty_point_today_rltb': instance.loyaltyPointTodayRltb,
      'frame_point': instance.framePoint,
      'frame_start_date': instance.frameStartDate,
      'frame_end_date': instance.frameEndDate,
    };
