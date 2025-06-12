// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessLocationModelImpl _$$BusinessLocationModelImplFromJson(
  Map<String, dynamic> json,
) => _$BusinessLocationModelImpl(
  locationId: (json['locationId'] as num).toInt(),
  locationName: json['locationName'] as String,
  contractNum: json['contractNum'] as String,
  contractDt: json['contractDt'] == null
      ? null
      : DateTime.parse(json['contractDt'] as String),
  status: json['status'] as bool? ?? true,
);

Map<String, dynamic> _$$BusinessLocationModelImplToJson(
  _$BusinessLocationModelImpl instance,
) => <String, dynamic>{
  'locationId': instance.locationId,
  'locationName': instance.locationName,
  'contractNum': instance.contractNum,
  'contractDt': instance.contractDt?.toIso8601String(),
  'status': instance.status,
};
