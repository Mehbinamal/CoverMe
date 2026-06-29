import 'package:flutter/material.dart';

import '../models/dashboard.dart';
import '../repositories/dashboard_repository.dart';

class DashboardProvider extends ChangeNotifier {
  final DashboardRepository _repository = DashboardRepository();

  Dashboard? dashboard;

  bool isLoading = false;

  String? error;

  Future<void> loadDashboard() async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();

      dashboard = await _repository.loadDashboard(
        day: DateTime.now().weekday,
        date: DateTime.now().toIso8601String().split('T').first,
      );

    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}