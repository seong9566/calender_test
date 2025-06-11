import 'package:flutter/material.dart';

/// 캘린더 이벤트 엔티티
/// 
/// 캘린더에 표시될 이벤트의 도메인 모델입니다.
class CalendarEventEntity {
  final String id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final Color color;
  final bool isAllDay;

  const CalendarEventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.color,
    this.isAllDay = false,
  });
}
