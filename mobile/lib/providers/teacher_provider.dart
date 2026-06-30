import 'package:flutter/material.dart';

import '../models/teacher.dart';
import '../repositories/teacher_repository.dart';

class TeacherProvider extends ChangeNotifier {
  final TeacherRepository _repository = TeacherRepository();

  List<Teacher> teachers = [];
  List<Teacher> filteredTeachers = [];

  bool isLoading = false;

  Future<void> loadTeachers() async {
    isLoading = true;
    notifyListeners();

    teachers = await _repository.getAllTeachers();
    filteredTeachers = teachers;

    isLoading = false;
    notifyListeners();
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredTeachers = teachers;
    } else {
      filteredTeachers = teachers.where((teacher) {
        return teacher.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}
