import 'task_item.dart';
import 'teacher.dart';
import 'timetable.dart';

class Dashboard {
  final Teacher hm;

  final List<Timetable?> timetable;

  final int pendingTasks;

  final int leaveCount;

  final TaskItem? currentPeriodTask;

  const Dashboard({
    required this.hm,

    required this.timetable,

    required this.pendingTasks,

    required this.leaveCount,
    required this.currentPeriodTask,
  });
}
