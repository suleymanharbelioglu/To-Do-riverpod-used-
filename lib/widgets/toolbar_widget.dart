import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/all_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ToolbarWidget extends ConsumerWidget {
  ToolbarWidget({super.key});
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            onCompletedTodoCount == 0
                ? "all tasks done"
                : onCompletedTodoCount.toString() + " task to do",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: "All Todos",
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.all)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            },
            child: Text("All"),
          ),
        ),
        Tooltip(
          message: "Only Uncompleted Todos",
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.active)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            },
            child: Text("Active"),
          ),
        ),
        Tooltip(
          message: "ONly Completed Todos",
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.completed)),
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed;
            },
            child: Text("Completed"),
          ),
        ),
      ],
    );
  }
}
