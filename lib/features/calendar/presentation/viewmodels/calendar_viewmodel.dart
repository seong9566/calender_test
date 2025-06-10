import 'package:calender_test/features/calendar/data/models/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'calendar_state.dart';

class CalendarViewModel extends StateNotifier<CalendarState> {
  CalendarViewModel() : super(const CalendarState());

  void initState() {
    // state = state.copyWith(todoList: []);
    state = state.copyWith(todoList: dummyTodos);
  }

  /// TODO 체크
  void checkTodo(int index, bool value) {
    /// 1. 변경할 TODO
    final todo = state.todoList[index];
    final List<TodoDetailModel> updatedDetails;

    /// 조건 1) 만약 TODO가 체크되어있다면 내부 하위 요소들도 모두 체크
    if (value) {
      updatedDetails = todo.todoDetailModel
          .map((detail) => detail.copyWith(isChecked: true))
          .toList();
    }
    /// 조건 2) TODO가 이미 체크 되어 있는 상태에서 다시 체크를 했다면 내부 하위 요소들 모두 해제
    else {
      updatedDetails = todo.todoDetailModel
          .map((detail) => detail.copyWith(isChecked: false))
          .toList();
    }

    /// 2. TODO 업데이트
    final updatedTodo = todo.copyWith(
      isChecked: value,
      todoDetailModel: updatedDetails,
    );

    /// 3. TODO List 업데이트
    final updatedTodoList = state.todoList
        .map((e) => e == todo ? updatedTodo : e)
        .toList();

    state = state.copyWith(todoList: updatedTodoList);
  }

  /// TODO의 Detail 체크
  void checkTodoDetail(int index, int detailIndex, bool value) {
    final todo = state.todoList[index];

    /// 1. detail 항목 체크/해제
    final updatedDetails = todo.todoDetailModel.asMap().entries.map((entry) {
      final i = entry.key;
      final detail = entry.value;
      return i == detailIndex ? detail.copyWith(isChecked: value) : detail;
    }).toList();

    // 모든 detail이 체크되었는지 확인
    final isAllDetailsChecked = updatedDetails.every(
      (d) => d.isChecked == true,
    );

    final updatedTodo = todo.copyWith(
      isChecked: isAllDetailsChecked,
      todoDetailModel: updatedDetails,
    );

    final updatedTodoList = state.todoList
        .map((e) => e == todo ? updatedTodo : e)
        .toList();

    state = state.copyWith(todoList: updatedTodoList);
  }
}
