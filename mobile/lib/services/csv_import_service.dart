import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

import '../models/timetable.dart';
import '../repositories/teacher_repository.dart';
import '../repositories/timetable_repository.dart';

class CsvImportService {
  final TeacherRepository teacherRepository = TeacherRepository();
  final TimetableRepository timetableRepository = TimetableRepository();

  static const Map<String, int> dayMap = {
    "MON": 1,
    "TUE": 2,
    "WED": 3,
    "THU": 4,
    "FRI": 5,
  };

  Future<void> importTimetable() async {
    print("Reading CSV...");

    final csvString = await rootBundle.loadString(
      "assets/data/teachers_timetable.csv",
    );

    final rows = const CsvToListConverter().convert(csvString);

    rows.removeAt(0); // Remove header

    print("Rows found: ${rows.length}");

    for (final row in rows) {
      final teacherCode = row[0].toString().trim();

      final day = dayMap[row[1].toString().trim().toUpperCase()]!;

      final period = (row[2] as num).toInt();

      final classroom = row[3].toString().trim();

      final subject = row[4].toString().trim();

      final teacherId = await teacherRepository.getOrCreateTeacher(teacherCode);

      await timetableRepository.insert(
        Timetable(
          teacherId: teacherId,
          day: day,
          period: period,
          classroom: classroom,
          subject: subject,
        ),
      );
    }

    print("CSV imported successfully.");
  }
}
