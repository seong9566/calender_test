// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_location_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BusinessLocationResponseModelImpl
_$$BusinessLocationResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$BusinessLocationResponseModelImpl(
      locationId: (json['locationId'] as num).toInt(),
      locationName: json['locationName'] as String,
      contractNum: json['contractNum'] as String,
      contractDt: json['contractDt'] == null
          ? null
          : DateTime.parse(json['contractDt'] as String),
      status: json['status'] as bool,
    );

Map<String, dynamic> _$$BusinessLocationResponseModelImplToJson(
  _$BusinessLocationResponseModelImpl instance,
) => <String, dynamic>{
  'locationId': instance.locationId,
  'locationName': instance.locationName,
  'contractNum': instance.contractNum,
  'contractDt': instance.contractDt?.toIso8601String(),
  'status': instance.status,
};
