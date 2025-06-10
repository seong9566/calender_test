import 'package:calender_test/core/extension/date_time_formatt_extension.dart';
import 'package:calender_test/features/calendar/data/models/todo_model.dart';
import 'package:calender_test/features/calendar/presentation/providers/calendar_providers_di.dart';
import 'package:calender_test/features/calendar/presentation/view/widgets/todo_card_item.dart';
import 'package:calender_test/features/calendar/presentation/view/widgets/todo_detail_bottom_sheet.dart';
import 'package:calender_test/features/provider/date/date_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DayTodoListView extends ConsumerStatefulWidget {
  const DayTodoListView({super.key});

  @override
  ConsumerState<DayTodoListView> createState() => _DayTodoListViewState();
}

class _DayTodoListViewState extends ConsumerState<DayTodoListView> {
  bool isChecked = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarViewModelProvider.notifier).initState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(dateProvider).selectedDate;
    final todos = ref.watch(calendarViewModelProvider).todoList;

    return RefreshIndicator(
      onRefresh: () async {
        ref.read(calendarViewModelProvider.notifier).initState();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _title(selectedDate),
          SizedBox(height: 16),
          _contents(todos),
        ],
      ),
    );
  }

  Widget _title(DateTime selectedDate) {
    return Text(
      selectedDate.toKoreanDate(),
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _contents(List<TodoModel> todos) {
    return Expanded(
      /// 데이터량이 많지 않으므로 단순 ListView 위젯을 사용.
      child: ListView(
        shrinkWrap: true,
        children: List.generate(
          todos.length,
          (index) => GestureDetector(
            onTap: () {
              showTodoDetailBottomSheet(context, index);
            },
            child: TodoCardItem(
              title: todos[index].title,
              onChanged: (value) {
                ref
                    .read(calendarViewModelProvider.notifier)
                    .checkTodo(index, value!);
              },
              isChecked: todos[index].isChecked,
            ),
          ),
        ),
      ),
    );
  }
}
