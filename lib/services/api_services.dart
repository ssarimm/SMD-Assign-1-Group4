import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo.dart';

class ApiService {
  static const String baseUrl = 'https://apimocker.com/todos';

  Future<List<Todo>> fetchTodos({required int page, int limit = 10}) async {
    final uri = Uri.parse('$baseUrl?page=$page&limit=$limit');
    try {
      final res = await http.get(uri);
      if (res.statusCode == 200) {
        final dynamic decodedData = json.decode(res.body);
        if (decodedData is List) {
          return decodedData.map((e) => Todo.fromJson(e)).toList();
        } else if (decodedData is Map && decodedData.containsKey('data')) {
          final List list = decodedData['data'];
          return list.map((e) => Todo.fromJson(e)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to load todos');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<Todo> createTodo({required String title, required String description}) async {
    final uri = Uri.parse(baseUrl);
    final body = json.encode({
      'title': title,
      'description': description,
      'isDone': false,
      'createdAt': DateTime.now().toIso8601String()
    });

    try {
      final res = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: body,
      ).timeout(const Duration(seconds: 5));

      if (res.statusCode >= 200 && res.statusCode < 300) {
        try {
          return Todo.fromJson(json.decode(res.body));
        } catch (e) {
          return Todo(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            title: title,
            description: description,
            isDone: false,
            createdAt: DateTime.now(),
          );
        }
      } else {
        return Todo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: title,
          description: description,
          isDone: false,
          createdAt: DateTime.now(),
        );
      }
    } catch (e) {
      return Todo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        description: description,
        isDone: false,
        createdAt: DateTime.now(),
      );
    }
  }

  Future<void> toggleTodo(String id, bool isDone) async {
    final uri = Uri.parse('$baseUrl/$id');
    try {
      final res = await http.patch(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'isDone': isDone}),
      );

      if (res.statusCode != 200 && res.statusCode != 204) {
        throw Exception('Failed to update status');
      }
    } catch (e) {
      // Local fallback
    }
  }
}