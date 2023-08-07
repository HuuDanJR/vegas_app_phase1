import 'dart:convert';

import 'package:flutter/material.dart';

class PromotionDetailModel {
  final int? attachmentId;
  final String? name;
  final String? term;
  final String? prize;
  final String? color;
  PromotionDetailModel(
      {this.attachmentId, this.name, this.term, this.prize, this.color});
}

class PromoRequest {
  List<int>? day;
  List<int>? dayOfMonth;
  int? dateOfWeek;
  int? month;
  Widget? widget;
  Widget? noteWidget;
  Widget? widgetColor;
  PromotionDetailModel? promotionDetailModel;

  PromoRequest(
      {this.day,
      this.month,
      this.dateOfWeek,
      this.widget,
      this.dayOfMonth,
      this.noteWidget,
      this.widgetColor,
      this.promotionDetailModel});
}

class DateCalendarRequest {
  int? day;
  List<Widget>? listWidget;
}

List<PromotionListModel> promotionListModelFromJson(String str) =>
    List<PromotionListModel>.from(
        json.decode(str).map((x) => PromotionListModel.fromJson(x)));

String promotionListModelToJson(List<PromotionListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PromotionListModel {
  PromotionListModel({
    this.date,
    this.promotion,
    this.name,
  });

  DateTime? date;
  String? name;
  List<PromotionDetailModel>? promotion;

  PromotionListModel copyWith({
    DateTime? date,
    List<PromotionDetailModel>? promotion,
    String? name,
  }) =>
      PromotionListModel(
        date: date ?? this.date,
        promotion: promotion ?? this.promotion,
        name: name ?? this.name,
      );

  factory PromotionListModel.fromJson(Map<String, dynamic> json) =>
      PromotionListModel(
        date: json["date"],
        promotion: json["promotion"] == null
            ? []
            : List<PromotionDetailModel>.from(json["promotion"]!.map((x) => x)),
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "promotion": promotion == null
            ? []
            : List<dynamic>.from(promotion!.map((x) => x)),
        "name": name,
      };
}
