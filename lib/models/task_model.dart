class TaskModel {
  final int id;
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.id,
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  TaskModel copyWith({
    int? id,
    String? taskName,
    String? taskDescription,
    bool? isHighPriority,
    bool? isDone,
  }) {
    return TaskModel(
      id: id ?? this.id,
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      isHighPriority: isHighPriority ?? this.isHighPriority,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone: json['isDone'],
    );
  }

  @override
  String toString() {
    return '''TaskModel(id: $id, taskName: $taskName, taskDescription: $taskDescription, isHighPriority: $isHighPriority, isDone: $isDone)''';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.id == id &&
        other.taskName == taskName &&
        other.taskDescription == taskDescription &&
        other.isHighPriority == isHighPriority &&
        other.isDone == isDone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        taskName.hashCode ^
        taskDescription.hashCode ^
        isHighPriority.hashCode ^
        isDone.hashCode;
  }
}
