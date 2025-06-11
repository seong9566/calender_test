import 'package:calender_test/features/calendar/data/calender_remote_data_source.dart';
import 'package:calender_test/features/calendar/data/models/calendar_event_model.dart';
import 'package:calender_test/network/dio_client.dart';
import 'package:dio/dio.dart';

/// 캘린더 원격 데이터 소스 구현체
class CalendarRemoteDataSourceImpl implements CalendarRemoteDataSource {
  final DioClient _dioClient;

  CalendarRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<CalendarEventModel>> getEvents() async {
    try {
      final response = await _dioClient.get('/events');
      final List<dynamic> data = response.data['data'] as List<dynamic>;
      return data.map((json) => CalendarEventModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e, '이벤트 조회 중 오류가 발생했습니다');
    }
  }

  @override
  Future<List<CalendarEventModel>> getEventsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    try {
      final response = await _dioClient.get(
        '/events/range',
        queryParameters: {
          'start': start.toIso8601String(),
          'end': end.toIso8601String(),
        },
      );
      final List<dynamic> data = response.data['data'] as List<dynamic>;
      return data.map((json) => CalendarEventModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e, '특정 기간 이벤트 조회 중 오류가 발생했습니다');
    }
  }

  @override
  Future<CalendarEventModel> createEvent(CalendarEventModel event) async {
    try {
      final response = await _dioClient.post('/events', data: event.toJson());
      return CalendarEventModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e, '이벤트 생성 중 오류가 발생했습니다');
    }
  }

  @override
  Future<CalendarEventModel> updateEvent(CalendarEventModel event) async {
    try {
      final response = await _dioClient.put(
        '/events/${event.id}',
        data: event.toJson(),
      );
      return CalendarEventModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e, '이벤트 업데이트 중 오류가 발생했습니다');
    }
  }

  @override
  Future<bool> deleteEvent(String eventId) async {
    try {
      final response = await _dioClient.delete('/events/$eventId');
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw _handleError(e, '이벤트 삭제 중 오류가 발생했습니다');
    }
  }

  /// Dio 예외 처리를 위한 헬퍼 메서드
  Exception _handleError(DioException e, String defaultMessage) {
    final statusCode = e.response?.statusCode;
    final responseMessage = e.response?.data?['message'] as String?;

    if (statusCode == 401) {
      return Exception('인증이 필요합니다. 다시 로그인해주세요.');
    } else if (statusCode == 403) {
      return Exception('접근 권한이 없습니다.');
    } else if (statusCode == 404) {
      return Exception('요청한 리소스를 찾을 수 없습니다.');
    } else {
      return Exception('$defaultMessage: ${responseMessage ?? e.message}');
    }
  }
}
