import 'package:freezed_annotation/freezed_annotation.dart';

part 'business_location_model.freezed.dart';
part 'business_location_model.g.dart';

@freezed
class BusinessLocationModel with _$BusinessLocationModel {
  const factory BusinessLocationModel({
    required int locationId,
    required String locationName,
    required String contractNum,
    DateTime? contractDt,
    @Default(true) bool status,
  }) = _BusinessLocationModel;

  factory BusinessLocationModel.fromJson(Map<String, dynamic> json) =>
      _$BusinessLocationModelFromJson(json);
}
