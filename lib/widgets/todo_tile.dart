import 'package:flutter/material.dart';
import '../models/todo.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;

  const TodoTile({super.key, required this.todo, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(todo.title, style: TextStyle(decoration: todo.done ? TextDecoration.lineThrough : null)),
      subtitle: Text(todo.description),
      trailing: IconButton(
        icon: Icon(todo.done ? Icons.undo : Icons.check, color: todo.done ? Colors.red : Colors.green),
        onPressed: onToggle,
      ),
    );
  }
}
