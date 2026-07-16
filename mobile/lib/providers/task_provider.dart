import 'package:flutter/material.dart';

import '../models/task_item.dart';

import '../repositories/task_repository.dart';
import '../repositories/teacher_repository.dart';

class TaskProvider extends ChangeNotifier {
  final TaskRepository _taskRepository = TaskRepository();

  final TeacherRepository _teacherRepository = TeacherRepository();

  List<TaskItem> pendingTasks = [];
  List<TaskItem> assignedTasks = [];
  List<TaskItem> allAssignedTasks = [];

  bool isLoading = false;

  Future<void> loadTasks() async {
    isLoading = true;

    notifyListeners();

    pendingTasks.clear();

    assignedTasks.clear();
    allAssignedTasks.clear();

    final today = DateTime.now().toIso8601String().split('T').first;

    //-----------------
    // Pending
    //-----------------

    final pending = await _taskRepository.getPendingTasks(date: today);

    for (final task in pending) {
      final absent = await _teacherRepository.getTeacherById(task.teacherId);

      if (absent != null) {
        pendingTasks.add(TaskItem(task: task, absentTeacher: absent));
      }
    }

    //-----------------
    // Assigned
    //-----------------

    final assigned = await _taskRepository.getAssignedTasks(date: today);

    for (final task in assigned) {
      final absent = await _teacherRepository.getTeacherById(task.teacherId);

      final substitute = await _teacherRepository.getTeacherById(
        task.assignedTeacherId!,
      );

      if (absent != null && substitute != null) {
        final taskItem = TaskItem(
          task: task,
          absentTeacher: absent,
          assignedTeacher: substitute,
        );

        assignedTasks.add(taskItem);
        allAssignedTasks.add(taskItem);
      }
    }

    isLoading = false;

    notifyListeners();
  }
}
