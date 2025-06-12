import 'package:calender_test/features/business/data/models/business_location_model.dart';
import 'package:calender_test/network/base_response.dart';

abstract class BusinessRepository {
  Future<BaseResponse<List<BusinessLocationModel>>> getBusinessLocations();
}
