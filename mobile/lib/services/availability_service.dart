import '../models/teacher.dart';
import '../repositories/teacher_repository.dart';
import '../repositories/timetable_repository.dart';
import '../repositories/leave_repository.dart';
import '../repositories/task_repository.dart';

class AvailabilityService {
  final TeacherRepository _teacherRepository = TeacherRepository();
  final TimetableRepository _timetableRepository = TimetableRepository();
  final LeaveRepository _leaveRepository = LeaveRepository();
  final TaskRepository _taskRepository = TaskRepository();

  Future<(List<Teacher>, List<Teacher>)> getAvailableTeachers({
    required int teacherId,
    required String classroom,
    required int day,
    required int period,
    required String date,
  }) async {
    final preferred = <Teacher>[];
    final others = <Teacher>[];

    final teachers = await _teacherRepository.getAllTeachers();
    print("Teachers found: ${teachers.length}");

    for (final teacher in teachers) {
      // Skip absent teacher
      if (teacher.id == teacherId) {
        continue;
      }

      // Skip HM
      if (teacher.name == "RM") {
        continue;
      }

      // Skip teachers on leave
      final onLeave = await _leaveRepository.isOnLeave(
        teacherId: teacher.id!,
        date: date,
      );

      if (onLeave) {
        continue;
      }

      // Skip teachers already assigned for this period
      final assigned = await _taskRepository.isTeacherAssigned(
        teacherId: teacher.id!,
        date: date,
        period: period,
      );

      if (assigned) {
        continue;
      }

      // Check if teacher has a class during this period
      final timetable = await _timetableRepository.getTeacherDayTimetable(
        teacher.id!,
        day,
      );

      bool busy = false;

      for (final entry in timetable) {
        if (entry.period == period) {
          busy = true;
          break;
        }
      }

      if (busy) {
        continue;
      }

      bool teachesSameClass = false;

      final weeklyTimetable = await _timetableRepository.teacherTimetable(
        teacher.id!,
      );

      for (final entry in weeklyTimetable) {
        if (entry.classroom == classroom) {
          teachesSameClass = true;
          break;
        }
      }

      if (teachesSameClass) {
        preferred.add(teacher);
      } else {
        others.add(teacher);
      }
    }

    print("Preferred teachers: ${preferred.length}");
    print("Other teachers: ${others.length}");

    return (preferred, others);
  }
}
