import '../models/teacher.dart';

import '../repositories/teacher_repository.dart';
import '../repositories/timetable_repository.dart';
import '../repositories/leave_repository.dart';
import '../repositories/task_repository.dart';

class AvailabilityService {
  final TeacherRepository teacherRepository = TeacherRepository();

  final TimetableRepository timetableRepository =
      TimetableRepository();

  final LeaveRepository leaveRepository =
      LeaveRepository();

  final TaskRepository taskRepository =
      TaskRepository();

  Future<(
    List<Teacher>,
    List<Teacher>,
  )> getAvailableTeachers({

    required int teacherId,

    required String classroom,

    required int day,

    required int period,

    required String date,

  }) async {

    final teachers =
        await teacherRepository.getAllTeachers();

    final busy =
        await timetableRepository.getByDayAndPeriod(
      day,
      period,
    );

    final leaves =
        await leaveRepository.getLeaves(date);

    final assigned =
        await taskRepository.getAssignedTasks(
      day: day,
      period: period,
    );

    final busyIds =
        busy.map((e) => e.teacherId).toSet();

    final leaveIds =
        leaves.map((e) => e.teacherId).toSet();

    final assignedIds =
        assigned
            .map((e) => e.assignedTeacherId)
            .whereType<int>()
            .toSet();

    final preferred = <Teacher>[];

    final others = <Teacher>[];

    for (final teacher in teachers) {

      if (teacher.id == teacherId) {
        continue;
      }

      if (busyIds.contains(teacher.id)) {
        continue;
      }

      if (leaveIds.contains(teacher.id)) {
        continue;
      }

      if (assignedIds.contains(teacher.id)) {
        continue;
      }

      final teachesSameClass =
          await timetableRepository.teachesClass(
        teacher.id!,
        classroom,
      );

      if (teachesSameClass) {
        preferred.add(teacher);
      } else {
        others.add(teacher);
      }
    }

    return (
      preferred,
      others,
    );
  }
}