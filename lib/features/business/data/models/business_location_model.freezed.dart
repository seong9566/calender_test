// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_location_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BusinessLocationModel _$BusinessLocationModelFromJson(
  Map<String, dynamic> json,
) {
  return _BusinessLocationModel.fromJson(json);
}

/// @nodoc
mixin _$BusinessLocationModel {
  int get locationId => throw _privateConstructorUsedError;
  String get locationName => throw _privateConstructorUsedError;
  String get contractNum => throw _privateConstructorUsedError;
  DateTime? get contractDt => throw _privateConstructorUsedError;
  bool get status => throw _privateConstructorUsedError;

  /// Serializes this BusinessLocationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BusinessLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BusinessLocationModelCopyWith<BusinessLocationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BusinessLocationModelCopyWith<$Res> {
  factory $BusinessLocationModelCopyWith(
    BusinessLocationModel value,
    $Res Function(BusinessLocationModel) then,
  ) = _$BusinessLocationModelCopyWithImpl<$Res, BusinessLocationModel>;
  @useResult
  $Res call({
    int locationId,
    String locationName,
    String contractNum,
    DateTime? contractDt,
    bool status,
  });
}

/// @nodoc
class _$BusinessLocationModelCopyWithImpl<
  $Res,
  $Val extends BusinessLocationModel
>
    implements $BusinessLocationModelCopyWith<$Res> {
  _$BusinessLocationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BusinessLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationId = null,
    Object? locationName = null,
    Object? contractNum = null,
    Object? contractDt = freezed,
    Object? status = null,
  }) {
    return _then(
      _value.copyWith(
            locationId: null == locationId
                ? _value.locationId
                : locationId // ignore: cast_nullable_to_non_nullable
                      as int,
            locationName: null == locationName
                ? _value.locationName
                : locationName // ignore: cast_nullable_to_non_nullable
                      as String,
            contractNum: null == contractNum
                ? _value.contractNum
                : contractNum // ignore: cast_nullable_to_non_nullable
                      as String,
            contractDt: freezed == contractDt
                ? _value.contractDt
                : contractDt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BusinessLocationModelImplCopyWith<$Res>
    implements $BusinessLocationModelCopyWith<$Res> {
  factory _$$BusinessLocationModelImplCopyWith(
    _$BusinessLocationModelImpl value,
    $Res Function(_$BusinessLocationModelImpl) then,
  ) = __$$BusinessLocationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int locationId,
    String locationName,
    String contractNum,
    DateTime? contractDt,
    bool status,
  });
}

/// @nodoc
class __$$BusinessLocationModelImplCopyWithImpl<$Res>
    extends
        _$BusinessLocationModelCopyWithImpl<$Res, _$BusinessLocationModelImpl>
    implements _$$BusinessLocationModelImplCopyWith<$Res> {
  __$$BusinessLocationModelImplCopyWithImpl(
    _$BusinessLocationModelImpl _value,
    $Res Function(_$BusinessLocationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BusinessLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? locationId = null,
    Object? locationName = null,
    Object? contractNum = null,
    Object? contractDt = freezed,
    Object? status = null,
  }) {
    return _then(
      _$BusinessLocationModelImpl(
        locationId: null == locationId
            ? _value.locationId
            : locationId // ignore: cast_nullable_to_non_nullable
                  as int,
        locationName: null == locationName
            ? _value.locationName
            : locationName // ignore: cast_nullable_to_non_nullable
                  as String,
        contractNum: null == contractNum
            ? _value.contractNum
            : contractNum // ignore: cast_nullable_to_non_nullable
                  as String,
        contractDt: freezed == contractDt
            ? _value.contractDt
            : contractDt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BusinessLocationModelImpl implements _BusinessLocationModel {
  const _$BusinessLocationModelImpl({
    required this.locationId,
    required this.locationName,
    required this.contractNum,
    this.contractDt,
    this.status = true,
  });

  factory _$BusinessLocationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BusinessLocationModelImplFromJson(json);

  @override
  final int locationId;
  @override
  final String locationName;
  @override
  final String contractNum;
  @override
  final DateTime? contractDt;
  @override
  @JsonKey()
  final bool status;

  @override
  String toString() {
    return 'BusinessLocationModel(locationId: $locationId, locationName: $locationName, contractNum: $contractNum, contractDt: $contractDt, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BusinessLocationModelImpl &&
            (identical(other.locationId, locationId) ||
                other.locationId == locationId) &&
            (identical(other.locationName, locationName) ||
                other.locationName == locationName) &&
            (identical(other.contractNum, contractNum) ||
                other.contractNum == contractNum) &&
            (identical(other.contractDt, contractDt) ||
                other.contractDt == contractDt) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    locationId,
    locationName,
    contractNum,
    contractDt,
    status,
  );

  /// Create a copy of BusinessLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BusinessLocationModelImplCopyWith<_$BusinessLocationModelImpl>
  get copyWith =>
      __$$BusinessLocationModelImplCopyWithImpl<_$BusinessLocationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BusinessLocationModelImplToJson(this);
  }
}

abstract class _BusinessLocationModel implements BusinessLocationModel {
  const factory _BusinessLocationModel({
    required final int locationId,
    required final String locationName,
    required final String contractNum,
    final DateTime? contractDt,
    final bool status,
  }) = _$BusinessLocationModelImpl;

  factory _BusinessLocationModel.fromJson(Map<String, dynamic> json) =
      _$BusinessLocationModelImpl.fromJson;

  @override
  int get locationId;
  @override
  String get locationName;
  @override
  String get contractNum;
  @override
  DateTime? get contractDt;
  @override
  bool get status;

  /// Create a copy of BusinessLocationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BusinessLocationModelImplCopyWith<_$BusinessLocationModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
