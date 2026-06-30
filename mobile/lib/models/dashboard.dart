import 'teacher.dart';
import 'timetable.dart';
import 'task.dart';
import 'leave.dart';

class Dashboard {
  final Teacher hm;

  final List<Timetable?> timetable;

  final int pendingTasks;

  final int leaveCount;

  const Dashboard({
    required this.hm,

    required this.timetable,

    required this.pendingTasks,

    required this.leaveCount,
  });
}
