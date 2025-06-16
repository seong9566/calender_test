import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:calender_test/network/base_response.dart';

/// 특정 기간 내의 캘린더 이벤트를 가져오는 유스케이스
class GetEventsByDateRangeUseCase {
  final CalendarRepository _repository;

  GetEventsByDateRangeUseCase(this._repository);

  /// 특정 기간 내의 캘린더 이벤트를 가져옵니다.
  /// BaseResponse에서 데이터를 추출하거나 예외를 처리합니다.
  Future<List<CalendarEventEntity>> execute(DateTime start, DateTime end) async {
    final response = await _repository.getEventsByDateRange(start, end);
    
    // 성공적으로 데이터를 가져왔을 경우
    if (response.code == 200) {
      return response.data;
    } 
    // 오류가 발생한 경우
    else {
      throw Exception('특정 기간 이벤트 조회 중 오류가 발생했습니다: ${response.message}');
    }
  }
}
