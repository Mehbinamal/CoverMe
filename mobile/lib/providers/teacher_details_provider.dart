import 'package:flutter/material.dart';

import '../models/teacher.dart';
import '../models/timetable.dart';
import '../repositories/timetable_repository.dart';

class TeacherDetailsProvider extends ChangeNotifier {
  final TimetableRepository _repository = TimetableRepository();

  final Map<int, List<Timetable?>> weeklyTimetable = {};

  bool isLoading = false;

  Future<void> loadTeacher(Teacher teacher) async {
    isLoading = true;
    notifyListeners();

    weeklyTimetable.clear();

    for (int day = 1; day <= 6; day++) {
      weeklyTimetable[day] = await _repository.getCompleteTeacherDay(
        teacher.id!,
        day,
      );
    }

    isLoading = false;
    notifyListeners();
  }
}
