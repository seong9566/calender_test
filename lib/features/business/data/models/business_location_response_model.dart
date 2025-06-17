import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_location_response_model.freezed.dart';
part 'business_location_response_model.g.dart';

@freezed
class BusinessLocationResponseModel with _$BusinessLocationResponseModel {
  const factory BusinessLocationResponseModel({
    required int locationId,
    required String locationName,
    required String contractNum,
    DateTime? contractDt,
    required bool status,
  }) = _BusinessLocationResponseModel;

  factory BusinessLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessLocationResponseModelFromJson(json);

  static List<BusinessLocationResponseModel> emptyList() {
    return [
      BusinessLocationResponseModel(
        locationId: 0,
        locationName: '',
        contractNum: '',
        contractDt: null,
        status: false,
      ),
    ];
  }
}

extension BusinessLocationResponseModelExtension
    on BusinessLocationResponseModel {
  BusinessLocationEntity toEntity() => BusinessLocationEntity(
    locationId: locationId,
    locationName: locationName,
    contractNum: contractNum,
    contractDt: contractDt,
    status: status,
    isSelected: false,
  );
}
