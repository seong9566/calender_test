import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/network/base_response.dart';

/// 캘린더 리포지토리 인터페이스
abstract class CalendarRepository {
  Future<BaseResponse<List<CalendarEventEntity>>> getEvents();

  Future<BaseResponse<List<CalendarEventEntity>>> getEventsByDateRange(
    DateTime start,
    DateTime end,
  );
}
