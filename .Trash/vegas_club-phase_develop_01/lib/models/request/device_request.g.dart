// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceRequest _$DeviceRequestFromJson(Map<String, dynamic> json) =>
    DeviceRequest(
      userId: json['user_id'] as int?,
      token: json['token'] as String?,
      deviceType: json['device_type'] as String?,
      timeExpired: json['time_expired'] as String?,
    );

Map<String, dynamic> _$DeviceRequestToJson(DeviceRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('user_id', instance.userId);
  writeNotNull('token', instance.token);
  writeNotNull('device_type', instance.deviceType);
  writeNotNull('time_expired', instance.timeExpired);
  return val;
}
