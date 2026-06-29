import 'package:flutter/material.dart';

import '../models/dashboard_model.dart';
import '../services/dashboard_service.dart';

class DashboardProvider extends ChangeNotifier {

  final DashboardService _service = DashboardService();

  DashboardModel? dashboard;

  bool isLoading = false;

  Future<void> loadDashboard() async {

    isLoading = true;

    notifyListeners();

    dashboard = await _service.getDashboard();

    isLoading = false;

    notifyListeners();

  }

}