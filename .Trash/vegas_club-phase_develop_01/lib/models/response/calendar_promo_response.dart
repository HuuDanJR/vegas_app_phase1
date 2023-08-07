// To parse this JSON data, do
//
//     final calendarPromoResponse = calendarPromoResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/models/response/date_of_season_response.dart';
part 'calendar_promo_response.g.dart';

List<CalendarPromoResponse> calendarPromoResponseFromJson(String str) =>
    List<CalendarPromoResponse>.from(
        json.decode(str).map((x) => CalendarPromoResponse.fromJson(x)));

String calendarPromoResponseToJson(List<CalendarPromoResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(includeIfNull: false)
class CalendarPromoResponse {
  CalendarPromoResponse({
    this.id,
    this.name,
    this.terms,
    this.prize,
    this.issueDate,
    this.gameType,
    this.dayOfWeek,
    this.dayOfMonth,
    this.dayOfSeason,
    this.time,
    this.remark,
    this.status,
    this.attachmentId,
    this.promotionCategoryId,
    this.promotionCategory,
    this.color,
    this.isSelected = false,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "terms")
  String? terms;
  @JsonKey(name: "prize")
  String? prize;
  @JsonKey(name: "issue_date")
  String? issueDate;
  @JsonKey(name: "game_type")
  String? gameType;
  @JsonKey(name: "day_of_week")
  String? dayOfWeek;
  @JsonKey(name: "day_of_month")
  String? dayOfMonth;
  @JsonKey(name: "day_of_season")
  String? dayOfSeason;
  @JsonKey(name: "time")
  String? time;
  @JsonKey(name: "remark")
  String? remark;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "attachment_id")
  int? attachmentId;
  @JsonKey(name: "promotion_category_id")
  int? promotionCategoryId;
  @JsonKey(name: "promotion_category")
  PromotionCategory? promotionCategory;
  @JsonKey(name: "color")
  String? color;
  bool? isSelected;

  CalendarPromoResponse copyWith({
    int? id,
    String? name,
    String? terms,
    String? prize,
    String? issueDate,
    String? gameType,
    String? dayOfWeek,
    String? dayOfMonth,
    String? dayOfSeason,
    String? time,
    String? remark,
    int? status,
    int? attachmentId,
    int? promotionCategoryId,
    PromotionCategory? promotionCategory,
    String? color,
    bool? isSelected,
  }) =>
      CalendarPromoResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        terms: terms ?? this.terms,
        prize: prize ?? this.prize,
        issueDate: issueDate ?? this.issueDate,
        gameType: gameType ?? this.gameType,
        dayOfWeek: dayOfWeek ?? this.dayOfWeek,
        dayOfMonth: dayOfMonth ?? this.dayOfMonth,
        dayOfSeason: dayOfSeason ?? this.dayOfSeason,
        time: time ?? this.time,
        remark: remark ?? this.remark,
        status: status ?? this.status,
        attachmentId: attachmentId ?? this.attachmentId,
        promotionCategoryId: promotionCategoryId ?? this.promotionCategoryId,
        promotionCategory: promotionCategory ?? this.promotionCategory,
        color: color ?? this.color,
        isSelected: isSelected ?? this.isSelected,
      );

  factory CalendarPromoResponse.fromJson(Map<String, dynamic> json) =>
      _$CalendarPromoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CalendarPromoResponseToJson(this);

  List<String> getListDayOfWeek() {
    List<String> listDayOfWeek = [];
    if (dayOfWeek == null || dayOfWeek!.isEmpty) {
      return [];
    }
    List<dynamic> listStr = json.decode(dayOfWeek!);
    listStr.map((e) {
      listDayOfWeek.add(e.toString());
    }).toList();
    return listDayOfWeek;
  }

  List<int> getListDayOfMonth() {
    List<int> listDayOfMonth = [];
    if (dayOfMonth == null || dayOfMonth!.isEmpty) {
      return [];
    }
    List<dynamic> listStr = json.decode(dayOfMonth!);
    listStr.map((e) {
      listDayOfMonth.add(e);
    }).toList();
    return listDayOfMonth;
  }

  List<DateOfSeasonResponse> getListDayOfSeason() {
    List<DateOfSeasonResponse>? listDayOfSeasonTmp = [];
    if (dayOfSeason == null || dayOfSeason!.isEmpty) {
      return [];
    }

    List<dynamic> listDayOfSeason = json.decode(dayOfSeason!);
    listDayOfSeason.map((e) {
      DateOfSeasonResponse dateOfSeasonResponse =
          DateOfSeasonResponse.fromJson(e);
      listDayOfSeasonTmp.add(dateOfSeasonResponse);
    }).toList();
    return listDayOfSeasonTmp;
  }
}

@JsonSerializable(includeIfNull: false)
class PromotionCategory {
  PromotionCategory({
    this.id,
    this.name,
  });

  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;

  PromotionCategory copyWith({
    int? id,
    String? name,
  }) =>
      PromotionCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory PromotionCategory.fromJson(Map<String, dynamic> json) =>
      _$PromotionCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionCategoryToJson(this);
}
