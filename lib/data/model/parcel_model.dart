import 'package:freezed_annotation/freezed_annotation.dart';

part 'parcel_model.freezed.dart';

part 'parcel_model.g.dart';

@freezed
class ParcelModel with _$ParcelModel {
  factory ParcelModel({
    String? id,
    String? parcelID,
    int? index,
    String? fileName,
    int? timestamp,
    String? state,
  }) = _ParcelModel;

  factory ParcelModel.fromJson(Map<String, dynamic> json) =>
      _$ParcelModelFromJson(json);

  @override
  Map<String, dynamic> toJson() {
    final map = super.toJson();
    map.remove("id");
    return map;
  }

}
