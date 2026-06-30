import '../core/constants/app_constants.dart';

import '../models/dashboard.dart';

import 'teacher_repository.dart';
import 'timetable_repository.dart';
import 'leave_repository.dart';
import 'task_repository.dart';

class DashboardRepository {
  final TeacherRepository teacherRepository = TeacherRepository();

  final TimetableRepository timetableRepository = TimetableRepository();

  final LeaveRepository leaveRepository = LeaveRepository();

  final TaskRepository taskRepository = TaskRepository();

  Future<Dashboard> loadDashboard({
    required int day,

    required String date,
  }) async {
    final hm = await teacherRepository.getTeacher(AppConstants.hmCode);

    if (hm == null) {
      throw Exception("HM not found.");
    }

    final timetable = await timetableRepository.getTeacherDayTimetable(
      hm.id!,
      day,
    );

    final pending = await taskRepository.pendingCount();

    final leaves = await leaveRepository.leaveCount(date);

    return Dashboard(
      hm: hm,

      timetable: timetable,

      pendingTasks: pending,

      leaveCount: leaves,
    );
  }
}
