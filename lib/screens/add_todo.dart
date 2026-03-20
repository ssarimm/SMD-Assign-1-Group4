import 'package:flutter/material.dart';
import '../services/api_services.dart';

class AddTodoScreen extends StatefulWidget {
  static const routeName = '/add-todo';
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  bool isSubmitting = false;

  final ApiService api = ApiService();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => isSubmitting = true);
    try {
      final todo = await api.createTodo(title: _titleController.text, description: _descController.text);
      if (mounted) Navigator.pop(context, todo);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Todo')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (val) => val == null || val.isEmpty ? 'Title required' : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (val) => val == null || val.isEmpty ? 'Description required' : null,
              ),
              const SizedBox(height: 20),
              isSubmitting
                  ? const CircularProgressIndicator()
                  : ElevatedButton(onPressed: _submit, child: const Text('Add')),
            ],
          ),
        ),
      ),
    );
  }
}
