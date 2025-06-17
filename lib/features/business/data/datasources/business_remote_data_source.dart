import 'package:calender_test/features/business/data/models/business_location_response_model.dart';
import 'package:calender_test/features/business/data/models/user_permission_response_model.dart';
import 'package:calender_test/network/base_response.dart';

abstract class BusinessRemoteDataSource {
  /// 사업장 목록 조회
  Future<BaseResponse<List<BusinessLocationResponseModel>>>
  getBusinessLocations();

  /// 사용자 사업장 권한 추가
  Future<BaseResponse<UserPermissionResponseModel>> addUserLocationPermission({
    int? locationId,
  });
}
