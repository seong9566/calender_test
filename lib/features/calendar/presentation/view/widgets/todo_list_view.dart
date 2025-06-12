import 'package:calender_test/core/extension/date_time_formatt_extension.dart';
import 'package:calender_test/features/calendar/data/models/todo_model.dart';
import 'package:calender_test/features/calendar/presentation/providers/calendar_providers_di.dart';
import 'package:calender_test/features/calendar/presentation/view/widgets/todo_card_item.dart';
import 'package:calender_test/features/calendar/presentation/view/widgets/todo_detail_bottom_sheet.dart';
import 'package:calender_test/features/calendar/presentation/view/widgets/todo_sliver_header_delegate.dart';
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
  ScrollController scrollController = ScrollController();
  bool _businessExpanded = true;
  bool _personalExpanded = true;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(calendarViewModelProvider.notifier).initState();
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void _toggleBusinessExpanded() {
    setState(() {
      _businessExpanded = !_businessExpanded;
    });
  }

  void _togglePersonalExpanded() {
    setState(() {
      _personalExpanded = !_personalExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(dateProvider).selectedDate;
    final todos = ref.watch(calendarViewModelProvider).todoList;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dateTitle(selectedDate),
        const SizedBox(height: 16),
        _contents(todos),
      ],
    );
  }

  Widget _dateTitle(DateTime selectedDate) {
    return Text(
      selectedDate.toKoreanDate(),
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _contents(List<TodoModel> todos) {
    // 사업장 할 일과 개인 할 일 분리
    final businessTodos = todos
        .where(
          (todo) =>
              todo.shareUserName.isNotEmpty &&
              todo.shareUserName != todo.createUserName,
        )
        .toList();
    final personalTodos = todos
        .where(
          (todo) =>
              todo.shareUserName.isEmpty ||
              todo.shareUserName == todo.createUserName,
        )
        .toList();

    return Expanded(
      child: CustomScrollView(
        controller: scrollController,
        slivers: [
          // 1. 사업장 할 일 헤더 (고정)
          SliverPersistentHeader(
            pinned: true,
            delegate: TodoSliverHeaderDelegate(
              title: '사업장 할 일',
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onTap: _toggleBusinessExpanded,
              isExpanded: _businessExpanded,
              height: 56.0, // 명시적으로 높이 지정
            ),
          ),

          // 2. 사업장 할 일 목록
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1.0,
                    child: child,
                  ),
                );
              },
              child: _businessExpanded
                  ? businessTodos.isEmpty
                        ? const Padding(
                            key: ValueKey('businessEmptyList'),
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(child: Text('등록된 사업장 할 일이 없습니다.')),
                          )
                        : Padding(
                            key: const ValueKey('businessListExpanded'),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: businessTodos.map((todo) {
                                return GestureDetector(
                                  onTap: () {
                                    final originalIndex = todos.indexOf(todo);
                                    showTodoDetailBottomSheet(
                                      context,
                                      originalIndex,
                                    );
                                  },
                                  child: TodoCardItem(
                                    title: todo.title,
                                    onChanged: (value) {
                                      final originalIndex = todos.indexOf(todo);
                                      ref
                                          .read(
                                            calendarViewModelProvider.notifier,
                                          )
                                          .checkTodo(originalIndex, value!);
                                    },
                                    isChecked: todo.isChecked,
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                  : const SizedBox.shrink(
                      key: ValueKey('businessListCollapsed'),
                    ),
            ),
          ),

          // 3. 개인 할 일 헤더 (고정)
          SliverPersistentHeader(
            pinned: true,
            delegate: TodoSliverHeaderDelegate(
              title: '개인 할 일',
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              onTap: _togglePersonalExpanded,
              isExpanded: _personalExpanded,
              height: 56.0, // 명시적으로 높이 지정
            ),
          ),

          // 4. 개인 할 일 목록
          SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1.0,
                    child: child,
                  ),
                );
              },
              child: _personalExpanded
                  ? personalTodos.isEmpty
                        ? const Padding(
                            key: ValueKey('personalEmptyList'),
                            padding: EdgeInsets.symmetric(vertical: 20.0),
                            child: Center(child: Text('등록된 개인 할 일이 없습니다.')),
                          )
                        : Padding(
                            key: const ValueKey('personalListExpanded'),
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: personalTodos.map((todo) {
                                return GestureDetector(
                                  onTap: () {
                                    final originalIndex = todos.indexOf(todo);
                                    showTodoDetailBottomSheet(
                                      context,
                                      originalIndex,
                                    );
                                  },
                                  child: TodoCardItem(
                                    title: todo.title,
                                    onChanged: (value) {
                                      final originalIndex = todos.indexOf(todo);
                                      ref
                                          .read(
                                            calendarViewModelProvider.notifier,
                                          )
                                          .checkTodo(originalIndex, value!);
                                    },
                                    isChecked: todo.isChecked,
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                  : const SizedBox.shrink(
                      key: ValueKey('personalListCollapsed'),
                    ),
            ),
          ),

          // 5. 하단 여백
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
        ],
      ),
    );
  }
}
