class Task {
  int? id;
  String title;
  String description;
  int? categoryId;
  String priority;
  String? dueDate;
  bool isCompleted;
  String? createdAt;
  String? updatedAt;
  String? categoryName;
  String? categoryColor;

  Task({
    this.id,
    required this.title,
    required this.description,
    this.categoryId,
    this.priority = 'medium',
    this.dueDate,
    this.isCompleted = false,
    this.createdAt,
    this.updatedAt,
    this.categoryName,
    this.categoryColor,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'] ?? '',
      categoryId: json['category_id'],
      priority: json['priority'] ?? 'medium',
      dueDate: json['due_date'],
      isCompleted: json['is_completed'] == 1,
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      categoryName: json['category_name'],
      categoryColor: json['category_color'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category_id': categoryId,
      'priority': priority,
      'due_date': dueDate,
      'is_completed': isCompleted,
    };
  }
}

class Category {
  int? id;
  String name;
  String color;

  Category({
    this.id,
    required this.name,
    required this.color,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      color: json['color'],
    );
  }
}