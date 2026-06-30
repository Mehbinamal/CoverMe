import 'package:flutter/material.dart';

import '../models/teacher.dart';
import '../repositories/leave_repository.dart';
import '../services/task_generation_service.dart';
import '../models/leave.dart';
import '../repositories/teacher_repository.dart';
import '../models/leave_item.dart';
import '../repositories/task_repository.dart';

class LeaveProvider extends ChangeNotifier {

  DateTime selectedDate = DateTime.now();

  List<LeaveItem> leaves = [];

  final TaskRepository _taskRepository = TaskRepository();

  final LeaveRepository _leaveRepository =
      LeaveRepository();

  final TaskGenerationService _taskService =
      TaskGenerationService();

  Teacher? selectedTeacher;

  DateTime selectedDate = DateTime.now();

  String reason = "";

  bool isSaving = false;

  void selectTeacher(Teacher teacher) {
    selectedTeacher = teacher;
    notifyListeners();
  }

  void setDate(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  void setReason(String value) {
    reason = value;
  }

  Future<bool> saveLeave() async {

    if (selectedTeacher == null) {
      return false;
    }


    isSaving = true;
    notifyListeners();

    final date =
        selectedDate
            .toIso8601String()
            .split('T')
            .first;

    if (await _leaveRepository.alreadyOnLeave(
      teacherId: selectedTeacher!.id!,
      date: date,
    )) {

        isSaving = false;
        notifyListeners();

        return false;
    }

    await _leaveRepository.addLeave(
      teacherId: selectedTeacher!.id!,
      date: date,
      reason: reason,
    );

    await _taskService.generateTasks(
      date: date,
    );

    isSaving = false;

    notifyListeners();

    return true;
  }

  Future<void> loadLeaves({
      required DateTime date,
    }) async {

    leaves.clear();
    selectedDate = date;

    final today =
        date.toIso8601String()
            .split('T')
            .first;

    final result =
        await _leaveRepository.getLeaves(today);

    for (final leave in result) {

      final teacher =
          await TeacherRepository()
              .getTeacherById(
                  leave.teacherId);

      if (teacher != null) {

        leaves.add(
          LeaveItem(
            leave: leave,
            teacher: teacher,
          ),
        );

      }

    }

    notifyListeners();

  }
  
  Future<void> delete(
    Leave leave,
    ) async {

    await _taskRepository.deleteTasksForLeave(
    teacherId: leave.teacherId,
    date: leave.date,
    );

    await _leaveRepository.deleteLeave(
    leave.id!,
    );

    await loadLeaves(
        date: selectedDate,
    );

    }
}