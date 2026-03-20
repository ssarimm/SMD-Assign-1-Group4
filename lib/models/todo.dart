class Todo {
  final String? id;
  final String title;
  final String description;
  bool isDone;
  final DateTime createdAt;

  Todo({
    this.id,
    required this.title,
    required this.description,
    bool done = false,
    bool? isDone,
    required this.createdAt,
  }) : isDone = isDone ?? done;

  // JSON Map -> Todo Object
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id']?.toString(),
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      isDone: json['isDone'] ?? json['completed'] ?? false,
      createdAt: DateTime.tryParse(json['createdAt']?.toString() ?? '') ?? DateTime.now(),
    );
  }

  bool get done => isDone;
  set done(bool value) => isDone = value;

  // Todo Object -> JSON Map
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}