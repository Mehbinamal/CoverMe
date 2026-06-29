import 'database_helper.dart';

class DatabaseInitializer {

  static Future<void> initialize() async {

    await DatabaseHelper.instance.database;

  }

}