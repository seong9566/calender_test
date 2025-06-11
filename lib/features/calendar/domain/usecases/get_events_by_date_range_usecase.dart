import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/features/calendar/domain/repositories/calendar_repository.dart';

/// 특정 기간 내의 캘린더 이벤트를 가져오는 유스케이스
class GetEventsByDateRangeUseCase {
  final CalendarRepository _repository;

  GetEventsByDateRangeUseCase(this._repository);

  /// 특정 기간 내의 캘린더 이벤트를 가져옵니다.
  Future<List<CalendarEventEntity>> execute(DateTime start, DateTime end) {
    return _repository.getEventsByDateRange(start, end);
  }
}
