// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calendar_promo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CalendarPromoResponse _$CalendarPromoResponseFromJson(
        Map<String, dynamic> json) =>
    CalendarPromoResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      terms: json['terms'] as String?,
      prize: json['prize'] as String?,
      issueDate: json['issue_date'] as String?,
      gameType: json['game_type'] as String?,
      dayOfWeek: json['day_of_week'] as String?,
      dayOfMonth: json['day_of_month'] as String?,
      dayOfSeason: json['day_of_season'] as String?,
      time: json['time'] as String?,
      remark: json['remark'] as String?,
      status: json['status'] as int?,
      attachmentId: json['attachment_id'] as int?,
      promotionCategoryId: json['promotion_category_id'] as int?,
      promotionCategory: json['promotion_category'] == null
          ? null
          : PromotionCategory.fromJson(
              json['promotion_category'] as Map<String, dynamic>),
      color: json['color'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$CalendarPromoResponseToJson(
    CalendarPromoResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('terms', instance.terms);
  writeNotNull('prize', instance.prize);
  writeNotNull('issue_date', instance.issueDate);
  writeNotNull('game_type', instance.gameType);
  writeNotNull('day_of_week', instance.dayOfWeek);
  writeNotNull('day_of_month', instance.dayOfMonth);
  writeNotNull('day_of_season', instance.dayOfSeason);
  writeNotNull('time', instance.time);
  writeNotNull('remark', instance.remark);
  writeNotNull('status', instance.status);
  writeNotNull('attachment_id', instance.attachmentId);
  writeNotNull('promotion_category_id', instance.promotionCategoryId);
  writeNotNull('promotion_category', instance.promotionCategory);
  writeNotNull('color', instance.color);
  writeNotNull('isSelected', instance.isSelected);
  return val;
}

PromotionCategory _$PromotionCategoryFromJson(Map<String, dynamic> json) =>
    PromotionCategory(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$PromotionCategoryToJson(PromotionCategory instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  return val;
}
