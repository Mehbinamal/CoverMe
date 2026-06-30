import 'package:flutter/material.dart';

import '../models/task.dart';
import '../models/teacher.dart';

import '../services/availability_service.dart';
import '../services/assignment_service.dart';

class AssignmentProvider extends ChangeNotifier {

  final AvailabilityService _availability =
      AvailabilityService();

  final AssignmentService _assignment =
      AssignmentService();

  List<Teacher> preferred = [];
  List<Teacher> others = [];

  Teacher? selectedTeacher;

  bool isLoading = false;

  Future<void> loadTeachers({
    required Task task,
    required String date,
  }) async {

    isLoading = true;

    notifyListeners();

    final result =
        await _availability.getAvailableTeachers(

      teacherId: task.teacherId,

      classroom: task.classroom,

      day: task.day,

      period: task.period,

      date: date,

    );

    preferred = result.$1;

    others = result.$2;

    isLoading = false;

    notifyListeners();

  }

  void selectTeacher(
      Teacher teacher,
  ) {

    selectedTeacher = teacher;

    notifyListeners();

  }

  Future<void> assign(
      int taskId,
  ) async {

    if(selectedTeacher==null){
      return;
    }

    await _assignment.assignTeacher(

      taskId: taskId,

      teacherId: selectedTeacher!.id!,

    );

  }

  Future<void> removeAssignment(
      int taskId,
  ) async {

    await _assignment.removeAssignment(
      taskId: taskId,
    );

  }

}