class TaskModel {
  final String taskName;
  final String taskDescription;
  final bool isHighPriority;
  bool isDone;

  TaskModel({
    required this.taskName,
    required this.taskDescription,
    required this.isHighPriority,
    this.isDone = false,
  });

  TaskModel copyWith({
    String? taskName,
    String? taskDescription,
    bool? isHighPriority,
  }) {
    return TaskModel(
      taskName: taskName ?? this.taskName,
      taskDescription: taskDescription ?? this.taskDescription,
      isHighPriority: isHighPriority ?? this.isHighPriority,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskName': taskName,
      'taskDescription': taskDescription,
      'isHighPriority': isHighPriority,
      'isDone': isDone,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      isHighPriority: json['isHighPriority'],
      isDone: json['isDone'] ?? false,
    );
  }

  @override
  String toString() =>
      '''TaskModel(taskName: $taskName, taskDescription: $taskDescription, isHighPriority: $isHighPriority)''';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskModel &&
        other.taskName == taskName &&
        other.taskDescription == taskDescription &&
        other.isHighPriority == isHighPriority;
  }

  @override
  int get hashCode =>
      taskName.hashCode ^ taskDescription.hashCode ^ isHighPriority.hashCode;
}
