// To parse this JSON data, do
//
//     final customerResponse = customerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/common/utils/extension.dart';
part 'customer_response.g.dart';

CustomerResponse customerResponseFromJson(String str) =>
    CustomerResponse.fromJson(json.decode(str));

String customerResponseToJson(CustomerResponse data) =>
    json.encode(data.toJson());

@JsonSerializable(includeIfNull: false)
@HiveType(typeId: 2)
class CustomerResponse {
  CustomerResponse({
    this.id,
    this.age,
    this.cardNumber,
    this.cashlessBalance,
    this.colour,
    this.colourHtml,
    this.compBalance,
    this.compStatusColour,
    this.compStatusColourHtml,
    this.forename,
    this.freeplayBalance,
    this.gender,
    this.hasOnlineAccount,
    this.hideCompBalance,
    this.isGuest,
    this.loyaltyBalance,
    this.loyaltyPointsAvailable,
    this.membershipTypeName,
    this.middleName,
    this.number,
    this.playerTierName,
    this.playerTierShortCode,
    this.premiumPlayer,
    this.surname,
    this.title,
    this.validMembership,
    this.userId,
    this.attachmentId,
    this.membershipLastIssueDate,
    this.nationality,
  });
  @JsonKey(name: "id")
  @HiveField(1)
  int? id;
  @JsonKey(name: "age")
  @HiveField(2)
  int? age;
  @JsonKey(name: "card_number")
  @HiveField(3)
  String? cardNumber;
  @JsonKey(name: "cashless_balance")
  @HiveField(4)
  int? cashlessBalance;
  @JsonKey(name: "colour")
  @HiveField(5)
  int? colour;
  @JsonKey(name: "colour_html")
  @HiveField(6)
  String? colourHtml;
  @JsonKey(name: "comp_balance")
  @HiveField(7)
  int? compBalance;
  @JsonKey(name: "comp_status_colour")
  @HiveField(8)
  int? compStatusColour;
  @JsonKey(name: "comp_status_colour_html")
  @HiveField(9)
  String? compStatusColourHtml;
  @JsonKey(name: "forename")
  @HiveField(10)
  String? forename;
  @JsonKey(name: "freeplay_balance")
  @HiveField(11)
  int? freeplayBalance;
  @JsonKey(name: "gender")
  @HiveField(12)
  String? gender;
  @JsonKey(name: "has_online_account")
  @HiveField(13)
  bool? hasOnlineAccount;
  @JsonKey(name: "hide_comp_balance")
  @HiveField(14)
  bool? hideCompBalance;
  @JsonKey(name: "is_guest")
  @HiveField(15)
  bool? isGuest;
  @JsonKey(name: "loyalty_balance")
  @HiveField(16)
  int? loyaltyBalance;
  @JsonKey(name: "loyalty_points_available")
  @HiveField(17)
  int? loyaltyPointsAvailable;
  @JsonKey(name: "membership_type_name")
  @HiveField(18)
  String? membershipTypeName;
  @JsonKey(name: "middle_name")
  @HiveField(19)
  String? middleName;
  @JsonKey(name: "number")
  @HiveField(20)
  int? number;
  @JsonKey(name: "player_tier_name")
  @HiveField(21)
  String? playerTierName;
  @JsonKey(name: "player_tier_short_code")
  @HiveField(22)
  String? playerTierShortCode;
  @JsonKey(name: "premium_player")
  @HiveField(23)
  bool? premiumPlayer;
  @JsonKey(name: "surname")
  @HiveField(24)
  String? surname;
  @JsonKey(name: "title")
  @HiveField(25)
  String? title;
  @JsonKey(name: "valid_membership")
  @HiveField(26)
  bool? validMembership;
  @JsonKey(name: "user_id")
  @HiveField(27)
  int? userId;
  @JsonKey(name: "attachment_id")
  @HiveField(28)
  int? attachmentId;
  @JsonKey(name: "membership_last_issue_date")
  @HiveField(29)
  DateTime? membershipLastIssueDate;
  @JsonKey(name: "nationality")
  String? nationality;

  CustomerResponse copyWith({
    int? id,
    int? age,
    String? cardNumber,
    int? cashlessBalance,
    int? colour,
    String? colourHtml,
    int? compBalance,
    int? compStatusColour,
    String? compStatusColourHtml,
    String? forename,
    int? freeplayBalance,
    String? gender,
    bool? hasOnlineAccount,
    bool? hideCompBalance,
    bool? isGuest,
    int? loyaltyBalance,
    int? loyaltyPointsAvailable,
    String? membershipTypeName,
    String? middleName,
    int? number,
    String? playerTierName,
    String? playerTierShortCode,
    bool? premiumPlayer,
    String? surname,
    String? title,
    bool? validMembership,
    int? userId,
    int? attachmentId,
    DateTime? membershipLastIssueDate,
    String? nationality,
  }) =>
      CustomerResponse(
          id: id ?? this.id,
          age: age ?? this.age,
          cardNumber: cardNumber ?? this.cardNumber,
          cashlessBalance: cashlessBalance ?? this.cashlessBalance,
          colour: colour ?? this.colour,
          colourHtml: colourHtml ?? this.colourHtml,
          compBalance: compBalance ?? this.compBalance,
          compStatusColour: compStatusColour ?? this.compStatusColour,
          compStatusColourHtml:
              compStatusColourHtml ?? this.compStatusColourHtml,
          forename: forename ?? this.forename,
          freeplayBalance: freeplayBalance ?? this.freeplayBalance,
          gender: gender ?? this.gender,
          hasOnlineAccount: hasOnlineAccount ?? this.hasOnlineAccount,
          hideCompBalance: hideCompBalance ?? this.hideCompBalance,
          isGuest: isGuest ?? this.isGuest,
          loyaltyBalance: loyaltyBalance ?? this.loyaltyBalance,
          loyaltyPointsAvailable:
              loyaltyPointsAvailable ?? this.loyaltyPointsAvailable,
          membershipTypeName: membershipTypeName ?? this.membershipTypeName,
          middleName: middleName ?? this.middleName,
          number: number ?? this.number,
          playerTierName: playerTierName ?? this.playerTierName,
          playerTierShortCode: playerTierShortCode ?? this.playerTierShortCode,
          premiumPlayer: premiumPlayer ?? this.premiumPlayer,
          surname: surname ?? this.surname,
          title: title ?? this.title,
          validMembership: validMembership ?? this.validMembership,
          userId: userId ?? this.userId,
          attachmentId: attachmentId ?? this.attachmentId,
          membershipLastIssueDate:
              membershipLastIssueDate ?? this.membershipLastIssueDate,
          nationality: nationality ?? this.nationality);

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => {
        "id": id,
        "age": age,
        "card number": cardNumber,
        "cashless balance": cashlessBalance,
        "colour": colour,
        "colour html": colourHtml,
        "comp balance": compBalance,
        "comp status colour": compStatusColour,
        "comp status colour html": compStatusColourHtml,
        "forename": forename,
        "freeplay balance": freeplayBalance,
        "gender": gender,
        "has online account": hasOnlineAccount,
        "hide comp balance": hideCompBalance,
        "is guest": isGuest,
        "loyalty balance": loyaltyBalance,
        "loyalty points available": loyaltyPointsAvailable,
        "membership type name": membershipTypeName,
        "middle name": middleName,
        "number": number,
        "player tier_name": playerTierName,
        "premium player": premiumPlayer,
        "surname": surname,
        "title": title,
        "valid membership": validMembership,
        "user Id": userId,
        "attachment id": attachmentId,
        "membership last issue date":
            membershipLastIssueDate!.toIso8601String(),
        "Name": getUserName(),
      };

  Map<String, dynamic> toTrackingJson() => {
        "membership type name": membershipTypeName,
        "number": number,
        "title": title,
        "Name": getUserName(),
      };

  String getMemberShipPeriod() {
    return "${membershipLastIssueDate!.parseDate("yyyy.MM.dd")} - ${membershipLastIssueDate!.toMonthAfter(3).parseDate("yyyy.MM.dd")}";
  }

  String getWallet() {
    return "\$${(cashlessBalance)?.toDecimal() ?? 0}";
  }

  String getMembershipPoint() {
    return loyaltyPointsAvailable!.toDecimal();
  }

  String getUserName() {
    if (surname == null && forename == null) {
      return "";
    }
    return '$surname $forename';
  }

  String getNationality() {
    return (nationality == null || nationality!.isEmpty) ? "N/A" : nationality!;
  }
}
