import '../core/constants/task_status.dart';

import '../models/task.dart';

import '../repositories/leave_repository.dart';
import '../repositories/task_repository.dart';
import '../repositories/timetable_repository.dart';

class TaskGenerationService {

  final LeaveRepository leaveRepository =
      LeaveRepository();

  final TimetableRepository timetableRepository =
      TimetableRepository();

  final TaskRepository taskRepository =
      TaskRepository();

  Future<void> generateTasks({

    required String date,

    required int day,

  }) async {

    final leaves =
        await leaveRepository.getLeaves(date);

    for(final leave in leaves){

      final timetable =
          await timetableRepository
              .getTeacherDayTimetable(
                    leave.teacherId,
                    day,
              );

      for(final period in timetable){

        await taskRepository.createTask(

          Task(

            teacherId: leave.teacherId,

            assignedTeacherId: null,

            day: day,

            period: period.period,

            classroom: period.classroom,

            subject: period.subject,

            status: TaskStatus.pending,

          ),

        );

      }

    }

  }

}