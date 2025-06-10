import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/todo_model.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({@Default([]) List<TodoModel> todoList}) =
      _CalendarState;
}

final List<TodoModel> dummyTodos = [
  TodoModel(
    title: '화장실 청소',
    isChecked: false,
    shareUserName: '철수',
    createUserName: '영희',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '변기 청소', isChecked: false),
      TodoDetailModel(detailTitle: '화장실 벽 청소', isChecked: false),
    ],
  ),
  TodoModel(
    title: '1층 로비 청소',
    isChecked: false,
    shareUserName: '민수',
    createUserName: '민수',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '로비 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '로비 바닥 청소', isChecked: false),
    ],
  ),
  TodoModel(
    title: '주차장 청소',
    isChecked: false,
    shareUserName: '지현',
    createUserName: '지현',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '주차장 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '주차장 바닥 청소', isChecked: false),
    ],
  ),
  TodoModel(
    title: '2층 라운지 청소',
    isChecked: false,
    shareUserName: '민지',
    createUserName: '민지',
    todoDetailModel: [
      TodoDetailModel(detailTitle: '라운지 벽 청소', isChecked: false),
      TodoDetailModel(detailTitle: '라운지 바닥 청소', isChecked: false),
    ],
  ),
];
