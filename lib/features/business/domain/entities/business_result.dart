import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';

/// 비즈니스 작업 결과 타입 정의
enum BusinessLocationsResultType { success, failure }

/// 비즈니스 작업 결과를 나타내는 도메인 클래스
class BusinessLocationsResult {
  final BusinessLocationsResultType type;
  final List<BusinessLocationEntity>? locations;
  final bool? hasPermission;
  final String? message;
  final int? code;

  /// 성공 결과 생성자
  const BusinessLocationsResult.success({
    this.locations,
    this.hasPermission,
    this.code,
    this.message,
  }) : type = BusinessLocationsResultType.success;

  /// 실패 결과 생성자
  const BusinessLocationsResult.failure({
    this.message,
    this.code,
  }) : type = BusinessLocationsResultType.failure,
       locations = null,
       hasPermission = null;
       
  /// 오류 결과 생성자 (이전 버전과의 호환성 유지)
  @Deprecated('Use failure instead')
  const BusinessLocationsResult.error({String? errorMessage, this.code})
    : type = BusinessLocationsResultType.failure,
      message = errorMessage,
      locations = null,
      hasPermission = null;
}
