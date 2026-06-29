import '../core/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/leave.dart';

class LeaveRepository {

  List<Leave> todayLeaves = [];

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

    Future<bool> alreadyOnLeave({
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

  Future<List<Leave>> getLeavesByDate(
      String date,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    final result = await db.query(
      "leave_table",
      where: "date=?",
      whereArgs: [date],
    );

    return result
        .map(Leave.fromMap)
        .toList();

  }

  Future<void> deleteLeave(
    int id,
  ) async {

    final db =
        await DatabaseHelper.instance.database;

    await db.delete(
      "leave_table",
      where: "id=?",
      whereArgs: [id],
    );

  }

  Future<void> loadTodayLeaves() async {

    final today =
        DateTime.now()
            .toIso8601String()
            .split('T')
            .first;

    todayLeaves =
        await _leaveRepository
            .getLeaves(today);

    notifyListeners();

  }
  Future<void> delete(
    Leave leave,
  ) async {

    await _leaveRepository
        .deleteLeave(
            leave.id!
        );

    await loadTodayLeaves();

  }
}