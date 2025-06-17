import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:calender_test/features/business/data/datasources/business_remote_data_source.dart';
import 'package:calender_test/features/business/data/models/business_location_response_model.dart';
import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:calender_test/features/business/domain/repositories/business_repository.dart';
import 'package:calender_test/network/base_response.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource _remoteDataSource;

  BusinessRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<BusinessLocationEntity>>>
  getBusinessLocations() async {
    final response = await _remoteDataSource.getBusinessLocations();
    return BaseResponse<List<BusinessLocationEntity>>(
      code: response.code,
      message: response.message,
      data: response.data.map((model) => model.toEntity()).toList(),
    );
  }

  @override
  Future<BaseResponse<bool>> addUserLocationPermission({
    int? locationId,
  }) async {
    final response = await _remoteDataSource.addUserLocationPermission(
      locationId: locationId,
    );

    if (response.code == 200) {
      // 사용자 권한 정보를 SecureStorage에 저장
      await SecureStorageUtil.saveUserPermission(response.data);
      return BaseResponse<bool>(
        code: response.code,
        message: response.message,
        data: true,
      );
    }
    return BaseResponse<bool>(
      code: response.code,
      message: response.message,
      data: false,
    );
  }
}
