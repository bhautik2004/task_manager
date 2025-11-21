class Task {
  int? id;
  String title;
  String description;
  String priority;
  String? dueDate;
  bool isCompleted;
  String? createdAt;
  String? updatedAt;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.priority = 'medium',
    this.dueDate,
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      priority: json['priority'] ?? 'medium',
      dueDate: json['due_date'],
      isCompleted: json['is_completed'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'due_date': dueDate,
      'is_completed': isCompleted,
    };
  }
}
