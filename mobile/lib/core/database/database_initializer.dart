import 'package:shared_preferences/shared_preferences.dart';

import '../../services/csv_import_service.dart';
import 'database_helper.dart';
import '../../repositories/task_repository.dart';

class DatabaseInitializer {
  static Future<void> initialize() async {

    await DatabaseHelper.instance.database;

    final prefs =
        await SharedPreferences.getInstance();

    final initialized =
        prefs.getBool("database_initialized") ??
            false;

    if (!initialized) {
      await CsvImportService().importTimetable(); 

      await prefs.setBool(
        "database_initialized",
        true,
      );

    await TaskRepository().deleteOldTasks();
    await TaskRepository().deleteOldTasks();
    }
  }
}