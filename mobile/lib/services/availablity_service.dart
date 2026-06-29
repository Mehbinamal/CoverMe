import '../models/teacher.dart';
import '../repositories/teacher_repository.dart';
import '../repositories/timetable_repository.dart';
import '../repositories/leave_repository.dart';

class AvailabilityService {
  final TeacherRepository teacherRepository = TeacherRepository();
  final TimetableRepository timetableRepository = TimetableRepository();
  final LeaveRepository leaveRepository = LeaveRepository();

  Future<List<Teacher>> getFreeTeachers({
    required int day,
    required int period,
    required String date,
  }) async {
    final teachers = await teacherRepository.getAllTeachers();

    final busyTeachers =
        await timetableRepository.getByDayAndPeriod(
      day,
      period,
    );

    final leaves =
        await leaveRepository.getLeaves(date);

    final leaveIds =
        leaves.map((e) => e.teacherId).toSet();

    final busyIds =
        busyTeachers.map((e) => e.teacherId).toSet();

    return teachers.where((teacher) {
      return !busyIds.contains(teacher.id) &&
          !leaveIds.contains(teacher.id);
    }).toList();
  }
}