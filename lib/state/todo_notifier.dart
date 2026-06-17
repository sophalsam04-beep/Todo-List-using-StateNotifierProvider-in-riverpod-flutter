import 'package:flutter/material.dart';
import 'package:riverpod/legacy.dart';
import 'package:self_learning7/model/todo_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoNotifier extends StateNotifier<List<TodoModel>> {
  TodoNotifier() : super([]);

  // Add todo
  void addTodo(String title) {
    final todo = TodoModel(
      id: DateTime.now().toString(),
      name: title,
      isCompleted: false,
    );

    state = [...state, todo];
  }

  // delete todo
  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }

  // Toggle Completed
  void toggleCompleted(String id) {
    state = state.map((todo) {
      if (todo.id == id) {
        return todo.copyWith(isCompleted: !todo.isCompleted);
      }

      return todo;
    }).toList();
  }
}



final todoProvider = StateNotifierProvider<TodoNotifier, List<TodoModel>>((ref){
    return TodoNotifier();
});
