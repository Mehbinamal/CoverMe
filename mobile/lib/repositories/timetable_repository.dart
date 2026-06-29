import '../core/database/database_helper.dart';
import '../models/timetable.dart';
import 'package:sqflite/sqflite.dart';

class TimetableRepository {
  Future<void> insert(
      Timetable timetable) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(
      "timetable",
      timetable.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<List<Timetable>> teacherTimetable(
      int teacherId) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "timetable",
      where: "teacherId=?",
      whereArgs: [teacherId],
      orderBy: "day,period",
    );

    return result
        .map(
          (e) => Timetable.fromMap(e),
        )
        .toList();
  }

  Future<List<Timetable>> periodEntries(
      int day,
      int period) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "timetable",
      where: "day=? AND period=?",
      whereArgs: [
        day,
        period,
      ],
    );

    return result
        .map(
          (e) => Timetable.fromMap(e),
        )
        .toList();
  }
}