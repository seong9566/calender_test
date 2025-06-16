import 'package:calender_test/core/storage/secure_storage_util.dart';
import 'package:calender_test/features/business/data/datasources/business_remote_data_source.dart';
import 'package:calender_test/features/business/data/models/user_permission_response_model.dart';
import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:calender_test/features/business/domain/repositories/business_repository.dart';
import 'package:calender_test/network/base_response.dart';

class BusinessRepositoryImpl implements BusinessRepository {
  final BusinessRemoteDataSource _remoteDataSource;

  BusinessRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<BusinessLocationEntity>>>
  getBusinessLocations() async {
    // RemoteDataSource에서 ResponseModel을 가져옴
    final response = await _remoteDataSource.getBusinessLocations();

    // ResponseModel을 Entity로 변환하여 반환
    // 여기서 데이터 계층(ResponseModel)에서 도메인 계층(Entity)으로의 변환이 이루어짐
    return BaseResponse<List<BusinessLocationEntity>>(
      code: response.code,
      message: response.message,
      data: response.data
          .map(
            (model) => BusinessLocationEntity(
              locationId: model.locationId,
              locationName: model.locationName,
              contractNum: model.contractNum,
              contractDt: model.contractDt,
              status: model.status,
              isSelected: false,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<BaseResponse<bool>> addUserLocationPermission({
    int? locationId,
  }) async {
    // RemoteDataSource에서 ResponseModel을 가져옴
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
