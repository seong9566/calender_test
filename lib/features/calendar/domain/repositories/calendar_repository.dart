import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/network/base_response.dart';

/// 캘린더 리포지토리 인터페이스
///
/// 캘린더 관련 데이터 액세스를 위한 추상화 계층입니다.
/// 도메인 계층에서 정의되며, 데이터 계층에 의존하지 않음
abstract class CalendarRepository {
  /// 모든 캘린더 이벤트를 가져옵니다.
  /// BaseResponse로 래핑된 CalendarEventEntity 리스트를 반환합니다.
  Future<BaseResponse<List<CalendarEventEntity>>> getEvents();

  /// 특정 기간 내의 캘린더 이벤트를 가져옵니다.
  /// BaseResponse로 래핑된 CalendarEventEntity 리스트를 반환합니다.
  Future<BaseResponse<List<CalendarEventEntity>>> getEventsByDateRange(
    DateTime start,
    DateTime end,
  );
}
