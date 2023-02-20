// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ParcelModel _$$_ParcelModelFromJson(Map<String, dynamic> json) =>
    _$_ParcelModel(
      id: json['id'] as String?,
      index: json['index'] as int?,
      fileName: json['fileName'] as String?,
      timestamp: (json['timestamp'] as num?)?.toDouble(),
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$_ParcelModelToJson(_$_ParcelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'fileName': instance.fileName,
      'timestamp': instance.timestamp,
      'state': instance.state,
    };
