import 'period_model.dart';

class DashboardModel {
  final int leaveCount;
  final int pendingTasks;

  final List<PeriodModel> timetable;

  const DashboardModel({
    required this.leaveCount,
    required this.pendingTasks,
    required this.timetable,
  });
}