import '../../../models/todo_model.dart';

sealed class TodoListState {
  const TodoListState();
}

final class TodoListStateInitial extends TodoListState {
  const TodoListStateInitial();

  @override
  String toString() => 'TodoListStateInitial()';
}

final class TodoListStateLoading extends TodoListState {
  const TodoListStateLoading();

  @override
  String toString() => 'TodoListStateLoading()';
}

final class TodoListStateSuccess extends TodoListState {
  final List<Todo> todos;

  const TodoListStateSuccess({
    required this.todos,
  });

  @override
  String toString() => 'TodoListStateSuccess()';
}

final class TodoListStateFailure extends TodoListState {
  final String error;

  const TodoListStateFailure({
    required this.error,
  });

  @override
  String toString() => 'TodoListStateFailure(error: $error)';
}