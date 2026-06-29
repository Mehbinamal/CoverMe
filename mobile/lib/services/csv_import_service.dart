import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:sqflite/sqflite.dart';

import '../core/database/database_helper.dart';

const Map<String, int> dayMap = {
  "MON": 1,
  "TUE": 2,
  "WED": 3,
  "THU": 4,
  "FRI": 5,
};

class CsvImportService {
  Future<void> importTimetable() async {
    final db = await DatabaseHelper.instance.database;

    final csvString =
        await rootBundle.loadString(
      "assets/data/teachers_timetable.csv",
    );

    final rows = CsvToListConverter(
      eol: "\n",
    ).convert(csvString);

    // Remove header
    rows.removeAt(0);

    await db.transaction((txn) async {
      final teacherCache = <String, int>{};
      final classroomCache = <String, int>{};
      final subjectCache = <String, int>{};

      for (final row in rows) {
        final teacher =
            row[0].toString().trim();

        final day =
            dayMap[row[1].toString().trim().toUpperCase()]!;

        final period =
            (row[2] as num).toInt();

        final classroom =
            row[3].toString().trim();

        final subject =
            row[4].toString().trim();
        //---------------------------------
        // Teacher
        //---------------------------------

        int teacherId;

        if (teacherCache.containsKey(teacher)) {
          teacherId = teacherCache[teacher]!;
        } else {
          teacherId = await _insertTeacher(
            txn,
            teacher,
          );

          teacherCache[teacher] =
              teacherId;
        }

        //---------------------------------
        // Classroom
        //---------------------------------

        int? classroomId;

        if (classroom.isNotEmpty) {
          if (classroomCache.containsKey(
              classroom)) {
            classroomId =
                classroomCache[classroom];
          } else {
            classroomId =
                await _insertClassroom(
              txn,
              classroom,
            );

            classroomCache[classroom] =
                classroomId;
          }
        }

        //---------------------------------
        // Subject
        //---------------------------------

        int? subjectId;

        if (subject.isNotEmpty) {
          if (subjectCache.containsKey(
              subject)) {
            subjectId =
                subjectCache[subject];
          } else {
            subjectId =
                await _insertSubject(
              txn,
              subject,
            );

            subjectCache[subject] =
                subjectId;
          }
        }

        //---------------------------------
        // Timetable
        //---------------------------------

        await txn.insert(
          "timetable",
          {
            "teacherId": teacherId,
            "classroomId": classroomId,
            "subjectId": subjectId,
            "day": day,
            "period": period,
          },
          conflictAlgorithm:
              ConflictAlgorithm.ignore,
        );
      }
    });
  }

  //----------------------------------------
  // Teacher
  //----------------------------------------

  Future<int> _insertTeacher(
    Transaction txn,
    String name,
  ) async {
    return await txn.insert(
      "teacher",
      {
        "name": name,
        "isHM": 0,
      },
      conflictAlgorithm:
          ConflictAlgorithm.ignore,
    );
  }

  //----------------------------------------

  Future<int> _insertClassroom(
    Transaction txn,
    String name,
  ) async {
    return await txn.insert(
      "classroom",
      {
        "name": name,
      },
      conflictAlgorithm:
          ConflictAlgorithm.ignore,
    );
  }

  //----------------------------------------

  Future<int> _insertSubject(
    Transaction txn,
    String name,
  ) async {
    return await txn.insert(
      "subject",
      {
        "name": name,
      },
      conflictAlgorithm:
          ConflictAlgorithm.ignore,
    );
  }

  Future<void> printTeachers() async {

    final db = await DatabaseHelper.instance.database;

    final teachers =
        await db.query("teacher");

    print(teachers);

}
}