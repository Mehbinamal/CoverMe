import 'package:flutter/material.dart';

import '../models/teacher.dart';
import '../repositories/leave_repository.dart';
import '../services/task_generation_service.dart';
import '../models/leave.dart';
import '../repositories/teacher_repository.dart';
import '../models/leave_item.dart';
import '../repositories/task_repository.dart';

class LeaveProvider extends ChangeNotifier {

  List<LeaveItem> todayLeaves = [];

  List<LeaveItem> upcomingLeaves = [];

  final TaskRepository _taskRepository = TaskRepository();

  final LeaveRepository _leaveRepository =
      LeaveRepository();

  final TaskGenerationService _taskService =
      TaskGenerationService();

  Teacher? selectedTeacher;

  String reason = "";

  bool isSaving = false;

  DateTime selectedDate = DateTime.now();

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

    final today = DateTime.now()
    .toIso8601String()
    .split('T')
    .first;

    if (date == today) {
    await _taskRepository.deleteTasksForDate(today);

    await _taskService.generateTasks(
      date: today,
    );
  }

    isSaving = false;

    notifyListeners();

    return true;
  }

  Future<void> loadLeaves() async {

    todayLeaves.clear();
    upcomingLeaves.clear();

    final today = DateTime.now()
        .toIso8601String()
        .split('T')
        .first;

    //-----------------------
    // Today's Leaves
    //-----------------------

    final todayResults =
        await _leaveRepository.getLeaves(today);

    for (final leave in todayResults) {

      final teacher =
          await TeacherRepository()
              .getTeacherById(
                  leave.teacherId);

      if (teacher != null) {

        todayLeaves.add(

          LeaveItem(
            leave: leave,
            teacher: teacher,
          ),

        );

      }

    }

    //-----------------------
    // Upcoming Leaves
    //-----------------------

    final upcomingResults =
        await _leaveRepository
            .getUpcomingLeaves();

    for (final leave in upcomingResults) {

      final teacher =
          await TeacherRepository()
              .getTeacherById(
                  leave.teacherId);

      if (teacher != null) {

        upcomingLeaves.add(

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

    await loadLeaves();

    }
}