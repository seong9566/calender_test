// import 'package:calender_test/features/calendar/domain/entities/calendar_event_entity.dart';
// import 'package:calender_test/features/calendar/presentation/providers/calendar_providers_di.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
// import 'package:intl/intl.dart';

// /// 캘린더 화면
// class CalendarView extends ConsumerStatefulWidget {
//   const CalendarView({Key? key}) : super(key: key);

//   @override
//   ConsumerState<CalendarView> createState() => _CalendarViewState();
// }

// class _CalendarViewState extends ConsumerState<CalendarView> {
//   final CalendarController _calendarController = CalendarController();
//   DateTime _selectedDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     // 현재 월의 이벤트 로드
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       ref.read(calendarViewModelProvider.notifier).loadEventsForCurrentMonth();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final calendarState = ref.watch(calendarViewModelProvider);
    
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('캘린더'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: () {
//               ref.read(calendarViewModelProvider.notifier).loadEventsForCurrentMonth();
//             },
//           ),
//         ],
//       ),
//       body: Column(
//         children: [
//           // 로딩 인디케이터
//           if (calendarState.isLoading)
//             const LinearProgressIndicator(),
          
//           // 에러 메시지
//           if (calendarState.errorMessage != null)
//             Container(
//               padding: const EdgeInsets.all(8),
//               color: Colors.red.shade100,
//               width: double.infinity,
//               child: Text(
//                 calendarState.errorMessage!,
//                 style: const TextStyle(color: Colors.red),
//               ),
//             ),
          
//           // 캘린더 위젯
//           Expanded(
//             child: SfCalendar(
//               controller: _calendarController,
//               view: CalendarView.month,
//               firstDayOfWeek: 1, // 월요일부터 시작
//               showNavigationArrow: true,
//               monthViewSettings: const MonthViewSettings(
//                 showAgenda: true,
//                 agendaViewHeight: 200,
//                 appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
//               ),
//               dataSource: _getCalendarDataSource(calendarState.events),
//               onViewChanged: (ViewChangedDetails details) {
//                 // 뷰가 변경될 때 해당 기간의 이벤트 로드
//                 if (details.visibleDates.isNotEmpty) {
//                   final startDate = details.visibleDates.first;
//                   final endDate = details.visibleDates.last;
//                   ref.read(calendarViewModelProvider.notifier).loadEventsByDateRange(
//                     startDate,
//                     endDate,
//                   );
//                 }
//               },
//               onTap: (CalendarTapDetails details) {
//                 if (details.targetElement == CalendarElement.calendarCell) {
//                   setState(() {
//                     _selectedDate = details.date!;
//                   });
                  
//                   // 선택한 날짜의 이벤트 표시
//                   final events = ref.read(calendarViewModelProvider.notifier)
//                       .getEventsForDay(_selectedDate);
                  
//                   if (events.isNotEmpty) {
//                     _showEventsDialog(context, events);
//                   }
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddEventDialog(context);
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }

//   /// 캘린더 이벤트 데이터 소스 생성
//   _AppointmentDataSource _getCalendarDataSource(List<CalendarEventEntity> events) {
//     List<Appointment> appointments = [];
    
//     for (var event in events) {
//       appointments.add(
//         Appointment(
//           startTime: event.startTime,
//           endTime: event.endTime,
//           subject: event.title,
//           notes: event.description,
//           color: event.color,
//           isAllDay: event.isAllDay,
//         ),
//       );
//     }
    
//     return _AppointmentDataSource(appointments);
//   }

//   /// 선택한 날짜의 이벤트 목록 다이얼로그 표시
//   void _showEventsDialog(BuildContext context, List<CalendarEventEntity> events) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(DateFormat('yyyy년 MM월 dd일').format(_selectedDate)),
//         content: SizedBox(
//           width: double.maxFinite,
//           child: ListView.builder(
//             shrinkWrap: true,
//             itemCount: events.length,
//             itemBuilder: (context, index) {
//               final event = events[index];
//               return ListTile(
//                 title: Text(event.title),
//                 subtitle: Text(event.description),
//                 leading: Container(
//                   width: 12,
//                   height: 12,
//                   decoration: BoxDecoration(
//                     color: event.color,
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//                 trailing: Text(
//                   '${DateFormat('HH:mm').format(event.startTime)} - ${DateFormat('HH:mm').format(event.endTime)}',
//                 ),
//               );
//             },
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('닫기'),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 이벤트 추가 다이얼로그 표시
//   void _showAddEventDialog(BuildContext context) {
//     // 실제 구현에서는 이벤트 추가 로직 구현
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('새 일정 추가'),
//         content: const Text('이벤트 추가 기능은 아직 구현되지 않았습니다.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('확인'),
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// 캘린더 이벤트 데이터 소스
// class _AppointmentDataSource extends CalendarDataSource {
//   _AppointmentDataSource(List<Appointment> source) {
//     appointments = source;
//   }
// }
