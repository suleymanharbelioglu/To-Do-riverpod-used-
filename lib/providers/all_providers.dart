import 'package:flutter_application_3/models/todo_model.dart';
import 'package:flutter_application_3/providers/todo_list_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider<TodoListFilter>(
  (ref) {
    return TodoListFilter.all;
  },
);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>(
  (ref) {
    return TodoListManager([
      TodoModel(id: const Uuid().v4(), description: "spora git"),
      TodoModel(id: const Uuid().v4(), description: "ders çalış"),
      TodoModel(id: const Uuid().v4(), description: "alışveriş"),
      TodoModel(id: const Uuid().v4(), description: "tv izle"),
    ]);
  },
);

final filteredTodoList = Provider<List<TodoModel>>(
  (ref) {
    final filter = ref.watch(todoListFilter);
    final todolist = ref.watch(todoListProvider);
    switch (filter) {
      case TodoListFilter.all:
        return todolist;
      case TodoListFilter.completed:
        return todolist
            .where(
              (element) => element.completed == true,
            )
            .toList();
      case TodoListFilter.active:
        return todolist
            .where(
              (element) => element.completed == false,
            )
            .toList();
    }
  },
);

final unCompletedTodoCount = Provider<int>(
  (ref) {
    final allTodo = ref.watch(todoListProvider);
    final count = allTodo
        .where(
          (element) => element.completed == false,
        )
        .length;
    return count;
  },
);

final currentTodoProvider = Provider<TodoModel>(
  (ref) {
    throw UnimplementedError();
  },
);
