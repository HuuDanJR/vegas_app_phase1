// To parse this JSON data, do
//
//     final officerResponse = officerResponseFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:vegas_club/common/constant/app_language.dart';
part 'officer_response.g.dart';

List<OfficerResponse> officerResponseFromJson(String str) =>
    List<OfficerResponse>.from(
        json.decode(str).map((x) => OfficerResponse.fromJson(x)));

String officerResponseToJson(List<OfficerResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable(includeIfNull: false)
class OfficerResponse {
  OfficerResponse({
    this.id,
    this.name,
    this.dateOfBirth,
    this.gender,
    this.homeTown,
    this.nationality,
    this.languageSupport,
    this.online,
    this.status,
    this.phone,
    this.attachmentId,
  });
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "date_of_birth")
  DateTime? dateOfBirth;
  @JsonKey(name: "gender")
  bool? gender;
  @JsonKey(name: "home_town")
  String? homeTown;
  @JsonKey(name: "nationality")
  String? nationality;
  @JsonKey(name: "language_support")
  String? languageSupport;
  @JsonKey(name: "online")
  bool? online;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "attachment_id")
  int? attachmentId;
  OfficerResponse copyWith({
    int? id,
    String? name,
    DateTime? dateOfBirth,
    bool? gender,
    String? homeTown,
    String? nationality,
    String? languageSupport,
    bool? online,
    int? status,
    String? phone,
    int? attachmentId,
  }) =>
      OfficerResponse(
        id: id ?? this.id,
        name: name ?? this.name,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth,
        gender: gender ?? this.gender,
        homeTown: homeTown ?? this.homeTown,
        nationality: nationality ?? this.nationality,
        languageSupport: languageSupport ?? this.languageSupport,
        online: online ?? this.online,
        status: status ?? this.status,
        phone: phone ?? this.phone,
        attachmentId: attachmentId ?? this.attachmentId,
      );

  factory OfficerResponse.fromJson(Map<String, dynamic> json) =>
      _$OfficerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OfficerResponseToJson(this);

  List<String> getListLanguage() {
    List<String> listLanguage = [];
    List<dynamic> jso = json.decode(languageSupport!);
    jso.map((e) {
      listLanguage.add(e.toString());
      getFlag(e.toString());
    }).toList();
    return listLanguage;
  }
}
