import 'package:calender_test/features/calendar/data/calender_remote_data_source.dart';
import 'package:calender_test/features/calendar/data/models/calendar_event_model.dart';
import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/features/calendar/domain/repositories/calendar_repository.dart';

/// 캘린더 리포지토리 구현체
class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDataSource _remoteDataSource;

  CalendarRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<CalendarEventEntity>> getEvents() async {
    try {
      final eventModels = await _remoteDataSource.getEvents();
      return eventModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('이벤트 조회 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<List<CalendarEventEntity>> getEventsByDateRange(DateTime start, DateTime end) async {
    try {
      final eventModels = await _remoteDataSource.getEventsByDateRange(start, end);
      return eventModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('특정 기간 이벤트 조회 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<CalendarEventEntity> createEvent(CalendarEventEntity event) async {
    try {
      final eventModel = CalendarEventModel.fromEntity(event);
      final createdModel = await _remoteDataSource.createEvent(eventModel);
      return createdModel.toEntity();
    } catch (e) {
      throw Exception('이벤트 생성 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<CalendarEventEntity> updateEvent(CalendarEventEntity event) async {
    try {
      final eventModel = CalendarEventModel.fromEntity(event);
      final updatedModel = await _remoteDataSource.updateEvent(eventModel);
      return updatedModel.toEntity();
    } catch (e) {
      throw Exception('이벤트 업데이트 중 오류가 발생했습니다: $e');
    }
  }

  @override
  Future<bool> deleteEvent(String eventId) async {
    try {
      return await _remoteDataSource.deleteEvent(eventId);
    } catch (e) {
      throw Exception('이벤트 삭제 중 오류가 발생했습니다: $e');
    }
  }
}
