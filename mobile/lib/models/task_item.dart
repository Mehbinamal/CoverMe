import 'task.dart';
import 'teacher.dart';

class TaskItem {
  final Task task;

  final Teacher absentTeacher;

  final Teacher? assignedTeacher;

  const TaskItem({
    required this.task,
    required this.absentTeacher,
    this.assignedTeacher,
  });
}