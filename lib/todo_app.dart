import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/all_providers.dart';
import 'package:flutter_application_3/widgets/title_widget.dart';
import 'package:flutter_application_3/widgets/todo_list_item_widget.dart';
import 'package:flutter_application_3/widgets/toolbar_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({super.key});
  final newTodoController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration: InputDecoration(
              labelText: "What will you do today ? ",
            ),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
              newTodoController.clear();
            },
          ),
          SizedBox(height: 20),
          ToolbarWidget(),
          allTodos.isEmpty
              ? Center(
                  child: Text("there is no task"),
                )
              : SizedBox(),
          for (var i = 0; i < allTodos.length; i++)
            Dismissible(
              key: ValueKey(allTodos[i].id),
              onDismissed: (direction) {
                ref.read(todoListProvider.notifier).remove(allTodos[i]);
              },
              child: ProviderScope(
                overrides: [
                  currentTodoProvider.overrideWithValue(allTodos[i]),
                ],
                child: TodoListItemWidget(),
              ),
            ),
        ],
      ),
    );
  }
}
