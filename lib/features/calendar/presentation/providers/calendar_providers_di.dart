import 'package:calender_test/features/calendar/presentation/viewmodels/calendar_state.dart';
import 'package:calender_test/features/calendar/presentation/viewmodels/calendar_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final calendarViewModelProvider =
    StateNotifierProvider<CalendarViewModel, CalendarState>((ref) {
      return CalendarViewModel();
    });
