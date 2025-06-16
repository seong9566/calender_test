import 'package:calender_test/features/business/data/models/business_location_response_model.dart';
import 'package:calender_test/features/business/data/models/user_permission_response_model.dart';
import 'package:calender_test/network/api_endpoint.dart';
import 'package:calender_test/network/api_error.dart';
import 'package:calender_test/network/base_response.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:dio/dio.dart';

abstract class BusinessRemoteDataSource {
  /// 사업장 목록 조회
  Future<BaseResponse<List<BusinessLocationResponseModel>>>
  getBusinessLocations();

  /// 사용자 사업장 권한 추가
  Future<BaseResponse<UserPermissionResponseModel>> addUserLocationPermission({
    int? locationId,
  });
}

class BusinessRemoteDataSourceImpl implements BusinessRemoteDataSource {
  final DioClient _dioClient;

  BusinessRemoteDataSourceImpl(this._dioClient);

  @override
  Future<BaseResponse<List<BusinessLocationResponseModel>>>
  getBusinessLocations() async {
    try {
      final response = await _dioClient.get(ApiEndPoint.businessLocations);
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;
      return BaseResponse.fromJson(
        responseData,
        (json) => (json as List)
            .map(
              (item) => BusinessLocationResponseModel.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList(),
      );
    } on DioException catch (e) {
      return ApiError.handleDioException<List<BusinessLocationResponseModel>>(
        e,
        (json) => (json as List)
            .map(
              (item) => BusinessLocationResponseModel.fromJson(
                item as Map<String, dynamic>,
              ),
            )
            .toList(),
        BusinessLocationResponseModel.emptyList(),
      );
    } catch (e) {
      return ApiError.handleGeneralException<
        List<BusinessLocationResponseModel>
      >(e, BusinessLocationResponseModel.emptyList());
    }
  }

  @override
  Future<BaseResponse<UserPermissionResponseModel>> addUserLocationPermission({
    int? locationId,
  }) async {
    try {
      final response = await _dioClient.post(
        ApiEndPoint.addUserLocationPermission,
        data: {"locationId": locationId},
      );
      final Map<String, dynamic> responseData =
          response.data as Map<String, dynamic>;

      return BaseResponse<UserPermissionResponseModel>.fromJson(
        responseData,
        (json) =>
            UserPermissionResponseModel.fromJson(json as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      return ApiError.handleDioException<UserPermissionResponseModel>(
        e,
        (json) => UserPermissionResponseModel.fromJson(json),
        UserPermissionResponseModel.empty(),
      );
    } catch (e) {
      return ApiError.handleGeneralException<UserPermissionResponseModel>(
        e,
        UserPermissionResponseModel.empty(),
      );
    }
  }
}
