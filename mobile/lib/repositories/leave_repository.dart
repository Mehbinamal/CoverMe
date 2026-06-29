import '../core/database/database_helper.dart';

class LeaveRepository {
  Future<void> addLeave({
    required int teacherId,
    required String date,
    String reason = "",
  }) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(
      "leave_table",
      {
        "teacherId": teacherId,
        "date": date,
        "reason": reason,
      },
    );
  }

  Future<List<Map<String, dynamic>>> getLeaves(
      String date) async {
    final db = await DatabaseHelper.instance.database;

    return db.query(
      "leave_table",
      where: "date=?",
      whereArgs: [date],
    );
  }
}