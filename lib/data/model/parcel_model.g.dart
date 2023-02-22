// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ParcelModel _$$_ParcelModelFromJson(Map<String, dynamic> json) =>
    _$_ParcelModel(
      id: json['id'] as String?,
      parcelID: json['parcelID'] as String?,
      index: json['index'] as int?,
      fileName: json['fileName'] as String?,
      timestamp: json['timestamp'] as int?,
      state: json['state'] as String?,
    );

Map<String, dynamic> _$$_ParcelModelToJson(_$_ParcelModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'parcelID': instance.parcelID,
      'index': instance.index,
      'fileName': instance.fileName,
      'timestamp': instance.timestamp,
      'state': instance.state,
    };
