// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'officer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfficerResponse _$OfficerResponseFromJson(Map<String, dynamic> json) =>
    OfficerResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      gender: json['gender'] as bool?,
      homeTown: json['home_town'] as String?,
      nationality: json['nationality'] as String?,
      languageSupport: json['language_support'] as String?,
      online: json['online'] as bool?,
      status: json['status'] as int?,
      phone: json['phone'] as String?,
      attachmentId: json['attachment_id'] as int?,
    );

Map<String, dynamic> _$OfficerResponseToJson(OfficerResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('date_of_birth', instance.dateOfBirth?.toIso8601String());
  writeNotNull('gender', instance.gender);
  writeNotNull('home_town', instance.homeTown);
  writeNotNull('nationality', instance.nationality);
  writeNotNull('language_support', instance.languageSupport);
  writeNotNull('online', instance.online);
  writeNotNull('status', instance.status);
  writeNotNull('phone', instance.phone);
  writeNotNull('attachment_id', instance.attachmentId);
  return val;
}
