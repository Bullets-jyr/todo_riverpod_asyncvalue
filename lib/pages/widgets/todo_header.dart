import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:todo_riverpod_asyncvalue/pages/providers/theme/theme_provider.dart';
import 'package:todo_riverpod_asyncvalue/pages/providers/todo_list/todo_list_provider.dart';

import '../../models/todo_model.dart';
import '../providers/todo_list/todo_list_state.dart';

class TodoHeader extends ConsumerStatefulWidget {
  const TodoHeader({super.key});

  @override
  ConsumerState<TodoHeader> createState() => _TodoHeaderState();
}

class _TodoHeaderState extends ConsumerState<TodoHeader> {
  Widget prevTodoCountWidget = const SizedBox.shrink();

  Widget getActiveTodoCount(List<Todo> todos) {
    final totalCount = todos.length;
    final activeTodoCount =
        todos.where((todo) => !todo.completed).toList().length;

    prevTodoCountWidget = Text(
      '($activeTodoCount/$totalCount item${activeTodoCount != 1 ? "s" : ""}) items left)',
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.blue[900],
      ),
    );

    return prevTodoCountWidget;
  }

  @override
  Widget build(BuildContext context) {
    // final activeTodoCount = ref.watch(activeTodoCountProvider);
    final todoListState = ref.watch(todoListProvider);

    switch (todoListState) {
      case TodoListStateLoading():
        context.loaderOverlay.show();
      case _:
        context.loaderOverlay.hide();
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Text(
              'TODO',
              style: TextStyle(fontSize: 36.0),
            ),
            const SizedBox(width: 10),
            switch (todoListState) {
              TodoListStateSuccess(todos: var todos) =>
                getActiveTodoCount(todos),
              _ => prevTodoCountWidget,
            },
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              icon: const Icon(Icons.light_mode),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                ref.read(todoListProvider.notifier).getTodos();
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      ],
    );
  }
}
