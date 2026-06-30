import 'package:flutter/material.dart';

import '../models/task_item.dart';

import '../repositories/task_repository.dart';
import '../repositories/teacher_repository.dart';

class TaskProvider extends ChangeNotifier {

  final TaskRepository _taskRepository =
      TaskRepository();

  final TeacherRepository _teacherRepository =
      TeacherRepository();

  List<TaskItem> tasks = [];

  bool isLoading = false;

  Future<void> loadTasks() async {

    isLoading = true;

    notifyListeners();

    tasks.clear();

    final today =
        DateTime.now()
            .toIso8601String()
            .split('T')
            .first;

    final pending =
        await _taskRepository
            .getPendingTasks(
              date: today,
            );

    for(final task in pending){

      final teacher =
          await _teacherRepository
              .getTeacherById(
                  task.teacherId
          );

      if(teacher!=null){

        tasks.add(

          TaskItem(

            task: task,

            teacher: teacher,

          ),

        );

      }

    }

    isLoading = false;

    notifyListeners();

  }

}