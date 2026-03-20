import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/api_services.dart';
import 'add_todo.dart';
import '../widgets/todo_tile.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final ApiService api = ApiService();
  final ScrollController _scrollController = ScrollController();

  List<Todo> todos = [];
  int page = 1;
  bool isLoading = false;
  bool hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchTodos();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 && !isLoading && hasMore) {
        _fetchTodos();
      }
    });
  }

  Future<void> _fetchTodos({bool refresh = false}) async {
    if (isLoading) return;
    setState(() => isLoading = true);
    try {
      if (refresh) {
        page = 1;
        todos.clear();
        hasMore = true;
      }
      final newTodos = await api.fetchTodos(page: page);
      setState(() {
        todos.addAll(newTodos);
        page++;
        if (newTodos.length < 10) hasMore = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _toggleDone(Todo todo) async {
    try {
      await api.toggleTodo(todo.id ?? '', !todo.done);
      setState(() {
        final idx = todos.indexWhere((t) => t.id == todo.id);
        if (idx != -1) {
          todos[idx] = Todo(
            id: todo.id,
            title: todo.title,
            description: todo.description,
            done: !todo.done,
            createdAt: todo.createdAt,
          );
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todos')),
      body: RefreshIndicator(
        onRefresh: () => _fetchTodos(refresh: true),
        child: ListView.builder(
          controller: _scrollController,
          itemCount: todos.length + (isLoading ? 1 : 0),
          itemBuilder: (ctx, i) {
            if (i < todos.length) {
              return TodoTile(todo: todos[i], onToggle: () => _toggleDone(todos[i]));
            } else {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTodo = await Navigator.pushNamed(context, AddTodoScreen.routeName);
          if (newTodo is Todo) {
            setState(() {
              todos.insert(0, newTodo); // newest at top
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
