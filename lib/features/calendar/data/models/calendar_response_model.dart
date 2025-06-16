import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'calendar_response_model.freezed.dart';
part 'calendar_response_model.g.dart';

/// 캘린더 이벤트 모델
///
/// API와의 통신에 사용되는 데이터 모델입니다.
@freezed
class CalendarResponseModel with _$CalendarResponseModel {
  const CalendarResponseModel._();

  const factory CalendarResponseModel({
    required String id,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    @JsonKey(includeToJson: false, includeFromJson: false)
    @Default(Colors.blue)
    Color color,
    @Default(false) bool isAllDay,
  }) = _CalendarResponseModel;

  /// JSON에서 모델 객체로 변환
  factory CalendarResponseModel.fromJson(Map<String, dynamic> json) =>
      _$CalendarResponseModelFromJson(json);

  static List<CalendarResponseModel> emptyList() {
    return [
      CalendarResponseModel(
        id: '',
        title: '',
        description: '',
        startTime: DateTime.now(),
        endTime: DateTime.now(),
        color: Colors.blue,
        isAllDay: false,
      ),
    ];
  }
}
