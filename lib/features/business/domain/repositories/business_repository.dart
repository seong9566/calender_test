import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:calender_test/network/base_response.dart';

/// 비즈니스 관련 데이터 접근을 위한 Repository 인터페이스
/// 도메인 계층에서 정의되며, 데이터 계층에 의존하지 않음
abstract class BusinessRepository {
  /// 사업장 위치 목록을 가져옴
  /// 도메인 엔티티인 BusinessLocationEntity 리스트를 반환
  Future<BaseResponse<List<BusinessLocationEntity>>> getBusinessLocations();

  /// 사용자 위치 권한 추가
  /// 도메인 엔티티인 UserPermissionEntity를 반환
  Future<BaseResponse<bool>> addUserLocationPermission({int? locationId});
}
