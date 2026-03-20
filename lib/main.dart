//Work done by Group4: 22k-4299, 22k-4561, 21k-4911, 21k-3379
import 'package:flutter/material.dart';
import 'screens/todo_list.dart';
import 'screens/add_todo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const TodoListScreen(),
      routes: {
        AddTodoScreen.routeName: (ctx) => const AddTodoScreen(),
      },
    );
  }
}
