enum TaskItemActionEnum {
  edit(name: 'Edit'),
  delete(name: 'Delete');

  final String name;

  const TaskItemActionEnum({required this.name});
}
