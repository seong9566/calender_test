import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_event_model.freezed.dart';
part 'calendar_event_model.g.dart';

/// 캘린더 이벤트 모델
///
/// API와의 통신에 사용되는 데이터 모델입니다.
@freezed
class CalendarEventModel with _$CalendarEventModel {
  const CalendarEventModel._();

  const factory CalendarEventModel({
    required String id,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(Colors.blue)
    Color color,
    @Default(false) bool isAllDay,
  }) = _CalendarEventModel;

  /// JSON에서 모델 객체로 변환
  factory CalendarEventModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarEventModelFromJson(json);

  /// 모델을 엔티티로 변환
  CalendarEventEntity toEntity() {
    return CalendarEventEntity(
      id: id,
      title: title,
      description: description,
      startTime: startTime,
      endTime: endTime,
      color: color,
      isAllDay: isAllDay,
    );
  }

  /// 엔티티에서 모델로 변환
  static CalendarEventModel fromEntity(CalendarEventEntity entity) {
    return CalendarEventModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      startTime: entity.startTime,
      endTime: entity.endTime,
      color: entity.color,
      isAllDay: entity.isAllDay,
    );
  }
}
