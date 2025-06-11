import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';

/// 캘린더 리포지토리 인터페이스
/// 
/// 캘린더 관련 데이터 액세스를 위한 추상화 계층입니다.
abstract class CalendarRepository {
  /// 모든 캘린더 이벤트를 가져옵니다.
  Future<List<CalendarEventEntity>> getEvents();
  
  /// 특정 기간 내의 캘린더 이벤트를 가져옵니다.
  Future<List<CalendarEventEntity>> getEventsByDateRange(DateTime start, DateTime end);
  
  /// 새로운 캘린더 이벤트를 생성합니다.
  Future<CalendarEventEntity> createEvent(CalendarEventEntity event);
  
  /// 기존 캘린더 이벤트를 업데이트합니다.
  Future<CalendarEventEntity> updateEvent(CalendarEventEntity event);
  
  /// 캘린더 이벤트를 삭제합니다.
  Future<bool> deleteEvent(String eventId);
}
