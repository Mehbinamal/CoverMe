import 'package:flutter/material.dart';

import '../models/teacher.dart';
import '../repositories/leave_repository.dart';
import '../services/task_generation_service.dart';

class LeaveProvider extends ChangeNotifier {

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

    if (await _leaveRepository.alreadyOnLeave(
      teacherId: selectedTeacher!.id!,
      date: date,
    )) {

        isSaving = false;
        notifyListeners();

        return false;
    }

    isSaving = true;
    notifyListeners();

    final date =
        selectedDate
            .toIso8601String()
            .split('T')
            .first;

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
}