// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pyramid_point_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PyramidPointResponse _$PyramidPointResponseFromJson(
        Map<String, dynamic> json) =>
    PyramidPointResponse(
      id: json['id'] as int?,
      prize: json['prize'] as String?,
      minPoint: json['min_point'] as int?,
      maxPoint: json['max_point'] as int?,
    );

Map<String, dynamic> _$PyramidPointResponseToJson(
        PyramidPointResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'prize': instance.prize,
      'min_point': instance.minPoint,
      'max_point': instance.maxPoint,
    };
