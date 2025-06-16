import 'package:calender_test/features/business/domain/entities/business_location_entity.dart';
import 'package:calender_test/features/business/domain/entities/business_result.dart';
import 'package:calender_test/features/business/domain/repositories/business_repository.dart';
import 'package:calender_test/network/base_response.dart';

/// 사업장 목록 조회 유스케이스
class GetBusinessLocationsUseCase {
  final BusinessRepository _repository;

  GetBusinessLocationsUseCase(this._repository);

  /// 사업장 목록 조회
  ///
  /// 반환값: [BusinessLocationsResult] 사업장 목록 조회 결과 정보
  Future<BusinessLocationsResult> execute() async {
    try {
      // API 호출
      final response = await _repository.getBusinessLocations();

      // 응답 처리 및 결과 반환
      return _processResponse(response);
    } catch (e) {
      // 기타 예외 발생 시 실패 결과 반환
      return BusinessLocationsResult.failure(message: e.toString());
    }
  }

  /// 응답 처리 및 결과 변환
  BusinessLocationsResult _processResponse(
    BaseResponse<List<BusinessLocationEntity>> response,
  ) {
    if (response.code == 200) {
      // 성공: Repository에서 이미 변환된 도메인 엔티티 사용
      return BusinessLocationsResult.success(
        locations: response.data,
        code: response.code,
        message: response.message,
      );
    } else {
      // 실패: 오류 메시지 반환
      return BusinessLocationsResult.failure(
        message: response.message,
        code: response.code,
      );
    }
  }
}
