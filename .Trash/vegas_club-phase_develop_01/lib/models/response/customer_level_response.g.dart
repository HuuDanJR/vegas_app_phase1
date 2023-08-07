// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_level_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerLevelResponseAdapter extends TypeAdapter<CustomerLevelResponse> {
  @override
  final int typeId = 6;

  @override
  CustomerLevelResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CustomerLevelResponse(
      level: fields[0] as String?,
      type: (fields[1] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, CustomerLevelResponse obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.level)
      ..writeByte(1)
      ..write(obj.type);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerLevelResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
