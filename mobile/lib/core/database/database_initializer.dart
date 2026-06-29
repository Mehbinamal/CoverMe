import 'package:shared_preferences/shared_preferences.dart';

import '../../services/csv_import_service.dart';
import 'database_helper.dart';

class DatabaseInitializer {
  static Future<void> initialize() async {

    print("Initializing database...");

    await DatabaseHelper.instance.database;

    print("Database initialized.");

    final prefs =
        await SharedPreferences.getInstance();

    final initialized =
        prefs.getBool("database_initialized") ??
            false;

    if (!initialized) {
      await CsvImportService().importTimetable();

      print("Timetable imported.");   

      await prefs.setBool(
        "database_initialized",
        true,
      );

  
    }
    print("complered");
  }
}