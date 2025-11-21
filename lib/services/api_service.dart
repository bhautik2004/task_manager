import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart';

// For physical device testing, replace with your computer's IP address
// Example: 'http://192.168.1.3:8000/task_manager/task_manager_api'
// To find your IP: Windows - ipconfig, macOS/Linux - ifconfig or ip addr
class ApiService {
  static const String baseUrl = 'http://192.168.1.3:8000/task_manager/task_manager_api'; // Change this for physical device

  static Future<List<Task>> getTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/read_tasks.php'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      List<dynamic> tasksData = data['data'];
      return tasksData.map((json) => Task.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }



  static Future<String> createTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/create_task.php'),
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
    final response = await http.post(
      Uri.parse('$baseUrl/update_task.php'),
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
    final response = await http.post(
      Uri.parse('$baseUrl/delete_task.php'),
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
