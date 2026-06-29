import '../core/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/leave.dart';

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

  Future<List<Leave>> getLeaves(String date) async {

  final db = await DatabaseHelper.instance.database;

  final result = await db.query(
    "leave_table",
    where: "date=?",
    whereArgs: [date],
  );

  return result
      .map((e)=>Leave.fromMap(e))
      .toList();

}

Future<bool> isOnLeave({
    required int teacherId,
    required String date,
    }) async {

    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
        "leave_table",
        where: "teacherId=? AND date=?",
        whereArgs: [
        teacherId,
        date,
        ],
        limit: 1,
    );

    return result.isNotEmpty;
    }

    Future<int> leaveCount(
        String date,
        ) async {

        final db =
            await DatabaseHelper.instance.database;

        final result =
            await db.rawQuery("""

        SELECT COUNT(*)

        FROM leave_table

        WHERE date=?

        """,[
            date,
        ]);

        return Sqflite.firstIntValue(result) ?? 0;

        }
}