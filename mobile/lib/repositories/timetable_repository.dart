import '../core/database/database_helper.dart';
import '../models/timetable.dart';
import 'package:sqflite/sqflite.dart';
import 'teacher_repository.dart';

class TimetableRepository {
  Future<void> insert(Timetable timetable) async {
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
        .map(Timetable.fromMap)
        .toList();
  }

  Future<List<Timetable>> getByDay(int day) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "timetable",
      where: "day=?",
      whereArgs: [day],
      orderBy: "period",
    );

    return result
        .map(Timetable.fromMap)
        .toList();
  }

  Future<List<Timetable>> getByDayAndPeriod(
      int day,
      int period,
  ) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "timetable",
      where: "day=? AND period=?",
      whereArgs: [day, period],
    );

    return result
        .map(Timetable.fromMap)
        .toList();
  }

  Future<Timetable?> getTeacherPeriod(
    int teacherId,
    int day,
    int period,
  ) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "timetable",
      where: "teacherId=? AND day=? AND period=?",
      whereArgs: [
        teacherId,
        day,
        period,
      ],
    );

    if (result.isEmpty) return null;

    return Timetable.fromMap(result.first);
  }

  Future<bool> teachesClass(
    int teacherId,
    String classroom,
    ) async {

    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
        "timetable",
        where: "teacherId=? AND classroom=?",
        whereArgs: [
        teacherId,
        classroom,
        ],
        limit: 1,
    );

    return result.isNotEmpty;
    }

    Future<List<Timetable>> getTeacherDayTimetable(
        int teacherId,
        int day,
        ) async {

        final db = await DatabaseHelper.instance.database;

        final result = await db.query(
            "timetable",
            where: "teacherId=? AND day=?",
            whereArgs: [
            teacherId,
            day,
            ],
            orderBy: "period",
        );

        return result
            .map(Timetable.fromMap)
            .toList();

    }

    Future<List<Timetable>> getTodayHM(
            int day,
        ) async {

            final hm =
                await TeacherRepository()
                    .getHM();

            if(hm==null){
                return [];
            }

            return teacherTimetable(
                hm.id!,
            );

        }
}