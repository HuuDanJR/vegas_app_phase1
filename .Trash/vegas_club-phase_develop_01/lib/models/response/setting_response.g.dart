// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'setting_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SettingResponseAdapter extends TypeAdapter<SettingResponse> {
  @override
  final int typeId = 3;

  @override
  SettingResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SettingResponse(
      id: fields[0] as int?,
      settingKey: fields[1] as String?,
      settingValue: fields[2] as String?,
      description: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, SettingResponse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.settingKey)
      ..writeByte(2)
      ..write(obj.settingValue)
      ..writeByte(3)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SettingResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SettingResponse _$SettingResponseFromJson(Map<String, dynamic> json) =>
    SettingResponse(
      id: json['id'] as int?,
      settingKey: json['setting_key'] as String?,
      settingValue: json['setting_value'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$SettingResponseToJson(SettingResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'setting_key': instance.settingKey,
      'setting_value': instance.settingValue,
      'description': instance.description,
    };
