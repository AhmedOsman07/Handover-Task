import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcel_model.freezed.dart';

part 'parcel_model.g.dart';

@freezed
class ParcelModel with _$ParcelModel {
  factory ParcelModel({
    String? id,
    int? index,
    String? fileName,
    double? timestamp,
    String? state,
  }) = _ParcelModel;

  factory ParcelModel.fromJson(Map<String, dynamic> json) =>
      _$ParcelModelFromJson(json);


}
