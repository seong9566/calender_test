import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/features/calendar/domain/repositories/calendar_repository.dart';

/// 모든 캘린더 이벤트를 가져오는 유스케이스
class GetEventsUseCase {
  final CalendarRepository _repository;

  GetEventsUseCase(this._repository);

  /// 모든 캘린더 이벤트를 가져옵니다.
  Future<List<CalendarEventEntity>> execute() {
    return _repository.getEvents();
  }
}
