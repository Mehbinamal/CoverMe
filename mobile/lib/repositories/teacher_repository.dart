import '../core/database/database_helper.dart';
import '../models/teacher.dart';

class TeacherRepository {
  Future<int> insertTeacher(
      Teacher teacher) async {
    final db = await DatabaseHelper.instance.database;

    return db.insert(
      "teacher",
      teacher.toMap(),
    );
  }

  Future<Teacher?> getTeacherByName(
      String name) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "teacher",
      where: "name=?",
      whereArgs: [name],
    );

    if (result.isEmpty) {
      return null;
    }

    return Teacher.fromMap(result.first);
  }

  Future<int> getOrCreateTeacher(
      String name) async {
    final teacher =
        await getTeacherByName(name);

    if (teacher != null) {
      return teacher.id!;
    }

    return insertTeacher(
      Teacher(name: name),
    );
  }

  Future<List<Teacher>> getAllTeachers() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "teacher",
      orderBy: "name",
    );

    return result
        .map(
          (e) => Teacher.fromMap(e),
        )
        .toList();
  }
}