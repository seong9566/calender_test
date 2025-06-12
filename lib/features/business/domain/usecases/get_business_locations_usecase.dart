import 'package:calender_test/features/business/data/models/business_location_model.dart';
import 'package:calender_test/features/business/domain/repositories/business_repository.dart';
import 'package:calender_test/network/base_response.dart';

/// 사업장 목록 조회 결과 타입 정의
enum BusinessLocationsResultType {
  /// 성공
  success,
  /// 실패
  error,
}

/// 사업장 목록 조회 결과 클래스
class BusinessLocationsResult {
  final BusinessLocationsResultType type;
  final List<BusinessLocationModel>? locations;
  final String? errorMessage;
  final int? code;

  BusinessLocationsResult.success({
    required this.locations,
    this.code,
  })  : type = BusinessLocationsResultType.success,
        errorMessage = null;

  BusinessLocationsResult.error({required this.errorMessage, this.code})
      : type = BusinessLocationsResultType.error,
        locations = null;
}

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
      // 기타 오류
      return BusinessLocationsResult.error(
        errorMessage: '사업장 목록을 가져오는 중 오류가 발생했습니다: ${e.toString()}',
      );
    }
  }

  /// 응답 처리 및 결과 변환
  BusinessLocationsResult _processResponse(
      BaseResponse<List<BusinessLocationModel>> response) {
    if (response.code == 200) {
      // 성공
      return BusinessLocationsResult.success(
        locations: response.data,
        code: response.code,
      );
    } else {
      // 실패
      return BusinessLocationsResult.error(
        errorMessage: response.message,
        code: response.code,
      );
    }
  }
}
