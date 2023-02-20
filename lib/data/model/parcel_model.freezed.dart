// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parcel_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ParcelModel _$ParcelModelFromJson(Map<String, dynamic> json) {
  return _ParcelModel.fromJson(json);
}

/// @nodoc
mixin _$ParcelModel {
  String? get id => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  String? get fileName => throw _privateConstructorUsedError;
  double? get timestamp => throw _privateConstructorUsedError;
  String? get state => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ParcelModelCopyWith<ParcelModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParcelModelCopyWith<$Res> {
  factory $ParcelModelCopyWith(
          ParcelModel value, $Res Function(ParcelModel) then) =
      _$ParcelModelCopyWithImpl<$Res, ParcelModel>;
  @useResult
  $Res call(
      {String? id,
      int? index,
      String? fileName,
      double? timestamp,
      String? state});
}

/// @nodoc
class _$ParcelModelCopyWithImpl<$Res, $Val extends ParcelModel>
    implements $ParcelModelCopyWith<$Res> {
  _$ParcelModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? fileName = freezed,
    Object? timestamp = freezed,
    Object? state = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as double?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ParcelModelCopyWith<$Res>
    implements $ParcelModelCopyWith<$Res> {
  factory _$$_ParcelModelCopyWith(
          _$_ParcelModel value, $Res Function(_$_ParcelModel) then) =
      __$$_ParcelModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      int? index,
      String? fileName,
      double? timestamp,
      String? state});
}

/// @nodoc
class __$$_ParcelModelCopyWithImpl<$Res>
    extends _$ParcelModelCopyWithImpl<$Res, _$_ParcelModel>
    implements _$$_ParcelModelCopyWith<$Res> {
  __$$_ParcelModelCopyWithImpl(
      _$_ParcelModel _value, $Res Function(_$_ParcelModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? index = freezed,
    Object? fileName = freezed,
    Object? timestamp = freezed,
    Object? state = freezed,
  }) {
    return _then(_$_ParcelModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      timestamp: freezed == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as double?,
      state: freezed == state
          ? _value.state
          : state // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ParcelModel implements _ParcelModel {
  _$_ParcelModel(
      {this.id, this.index, this.fileName, this.timestamp, this.state});

  factory _$_ParcelModel.fromJson(Map<String, dynamic> json) =>
      _$$_ParcelModelFromJson(json);

  @override
  final String? id;
  @override
  final int? index;
  @override
  final String? fileName;
  @override
  final double? timestamp;
  @override
  final String? state;

  @override
  String toString() {
    return 'ParcelModel(id: $id, index: $index, fileName: $fileName, timestamp: $timestamp, state: $state)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ParcelModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.state, state) || other.state == state));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, index, fileName, timestamp, state);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParcelModelCopyWith<_$_ParcelModel> get copyWith =>
      __$$_ParcelModelCopyWithImpl<_$_ParcelModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ParcelModelToJson(
      this,
    );
  }
}

abstract class _ParcelModel implements ParcelModel {
  factory _ParcelModel(
      {final String? id,
      final int? index,
      final String? fileName,
      final double? timestamp,
      final String? state}) = _$_ParcelModel;

  factory _ParcelModel.fromJson(Map<String, dynamic> json) =
      _$_ParcelModel.fromJson;

  @override
  String? get id;
  @override
  int? get index;
  @override
  String? get fileName;
  @override
  double? get timestamp;
  @override
  String? get state;
  @override
  @JsonKey(ignore: true)
  _$$_ParcelModelCopyWith<_$_ParcelModel> get copyWith =>
      throw _privateConstructorUsedError;
}
