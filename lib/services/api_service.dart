import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.1.3/task_manager/backend/api';

  static Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> tasksData = data['data'];
      return tasksData.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  static Future<List<Category>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> categoriesData = data['data'];
      return categoriesData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<String> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return 'Task created successfully';
    } else {
      throw Exception('Failed to create task');
    }
  }

  static Future<String> updateTask(Task task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200) {
      return 'Task updated successfully';
    } else {
      throw Exception('Failed to update task');
    }
  }

  static Future<String> deleteTask(int taskId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/tasks.php'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': taskId}),
    );

    if (response.statusCode == 200) {
      return 'Task deleted successfully';
    } else {
      throw Exception('Failed to delete task');
    }
  }
}