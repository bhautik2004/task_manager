import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/api_service.dart';
import 'add_edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    try {
      final loadedTasks = await ApiService.getTasks();
      setState(() {
        tasks = loadedTasks;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading tasks: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _deleteTask(int taskId) async {
    try {
      await ApiService.deleteTask(taskId);
      _loadTasks(); // Reload the task list
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Task deleted successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
  }

  void _toggleTaskCompletion(Task task) async {
    task.isCompleted = !task.isCompleted;
    try {
      await ApiService.updateTask(task);
      _loadTasks();
    } catch (e) {
      print('Error updating task: $e');
    }
  }

  Color _getPriorityColor(String priority) {
    switch (priority) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : tasks.isEmpty
          ? Center(child: Text('No tasks found. Add some tasks!'))
          : ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: ListTile(
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) => _toggleTaskCompletion(task),
              ),
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(task.description),
                  if (task.categoryName != null)
                    Chip(
                      label: Text(
                        task.categoryName!,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Color(int.parse(
                          task.categoryColor!.replaceAll('#', '0xFF'))),
                    ),
                  Row(
                    children: [
                      Icon(Icons.flag, size: 16,
                          color: _getPriorityColor(task.priority)),
                      SizedBox(width: 4),
                      Text(task.priority.toUpperCase()),
                      if (task.dueDate != null) ...[
                        SizedBox(width: 16),
                        Icon(Icons.calendar_today, size: 16),
                        SizedBox(width: 4),
                        Text(task.dueDate!),
                      ],
                    ],
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddEditTaskScreen(
                            task: task,
                            onTaskSaved: _loadTasks,
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteTask(task.id!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEditTaskScreen(onTaskSaved: _loadTasks),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}