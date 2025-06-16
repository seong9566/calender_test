import 'package:calender_test/network/base_response.dart';
import 'package:dio/dio.dart';

class ApiError {
  /// DioException 처리를 위한 공통 메서드
  static BaseResponse<T> handleDioException<T>(
    DioException e,
    T Function(Map<String, dynamic>) fromJson,
    T defaultValue,
  ) {
    try {
      if (e.response != null && e.response!.data != null) {
        final Map<String, dynamic> errorResponseData =
            e.response!.data as Map<String, dynamic>;
        return BaseResponse<T>.fromJson(errorResponseData, (json) {
          if (json == null) return defaultValue;
          // 안전한 타입 체크 및 캐스트
          if (json is Map<String, dynamic>) {
            return fromJson(json);
          }
          return defaultValue;
        });
      }
      return BaseResponse<T>(
        code: e.response?.statusCode ?? 500,
        message: '네트워크 오류: ${e.message}',
        data: defaultValue,
      );
    } catch (parseError) {
      return BaseResponse<T>(
        code: e.response?.statusCode ?? 500,
        message: '응답 파싱 오류: $parseError',
        data: defaultValue,
      );
    }
  }

  /// 일반 예외 처리를 위한 공통 메서드
  static BaseResponse<T> handleGeneralException<T>(Object e, T defaultValue) {
    return BaseResponse<T>(
      code: 500,
      message: '예상치 못한 오류 발생: $e',
      data: defaultValue,
    );
  }
}
