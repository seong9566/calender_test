import 'package:calender_test/features/calendar/data/datasources/calendar_remote_data_source.dart';
import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:calender_test/features/calendar/domain/repositories/calendar_repository.dart';
import 'package:calender_test/network/base_response.dart';

/// 캘린더 리포지토리 구현체
class CalendarRepositoryImpl implements CalendarRepository {
  final CalendarRemoteDataSource _remoteDataSource;

  CalendarRepositoryImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<List<CalendarEventEntity>>> getEvents() async {
    // RemoteDataSource에서 ResponseModel을 가져옴
    final response = await _remoteDataSource.getEvents();

    return BaseResponse<List<CalendarEventEntity>>(
      code: response.code,
      message: response.message,
      data: response.data
          .map(
            (model) => CalendarEventEntity(
              id: model.id,
              title: model.title,
              description: model.description,
              startTime: model.startTime,
              endTime: model.endTime,
              color: model.color,
              isAllDay: model.isAllDay,
            ),
          )
          .toList(),
    );
  }

  @override
  Future<BaseResponse<List<CalendarEventEntity>>> getEventsByDateRange(
    DateTime start,
    DateTime end,
  ) async {
    // RemoteDataSource에서 ResponseModel을 가져옴
    final response = await _remoteDataSource.getEventsByDateRange(start, end);

    return BaseResponse<List<CalendarEventEntity>>(
      code: response.code,
      message: response.message,
      data: response.data
          .map(
            (model) => CalendarEventEntity(
              id: model.id,
              title: model.title,
              description: model.description,
              startTime: model.startTime,
              endTime: model.endTime,
              color: model.color,
              isAllDay: model.isAllDay,
            ),
          )
          .toList(),
    );
  }
}
