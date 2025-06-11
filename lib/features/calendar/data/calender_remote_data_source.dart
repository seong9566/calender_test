import 'package:calender_test/features/calendar/data/models/calendar_event_model.dart';

/// 캘린더 원격 데이터 소스 인터페이스
/// 
/// API와의 통신을 담당하는 인터페이스입니다.
abstract class CalendarRemoteDataSource {
  /// 모든 캘린더 이벤트를 가져옵니다.
  Future<List<CalendarEventModel>> getEvents();
  
  /// 특정 기간 내의 캘린더 이벤트를 가져옵니다.
  Future<List<CalendarEventModel>> getEventsByDateRange(DateTime start, DateTime end);
  
  /// 새로운 캘린더 이벤트를 생성합니다.
  Future<CalendarEventModel> createEvent(CalendarEventModel event);
  
  /// 기존 캘린더 이벤트를 업데이트합니다.
  Future<CalendarEventModel> updateEvent(CalendarEventModel event);
  
  /// 캘린더 이벤트를 삭제합니다.
  Future<bool> deleteEvent(String eventId);
}
