import '../core/database/database_helper.dart';
import '../models/teacher.dart';

class TeacherRepository {
  Future<int> insertTeacher(Teacher teacher) async {
    final db = await DatabaseHelper.instance.database;

    return db.insert(
      "teacher",
      teacher.toMap(),
    );
  }

  Future<Teacher?> getTeacher(String teacherCode) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "teacher",
      where: "name=?",
      whereArgs: [teacherCode],
    );

    if (result.isEmpty) return null;

    return Teacher.fromMap(result.first);
  }

  Future<int> getOrCreateTeacher(String teacherCode) async {
    final teacher = await getTeacher(teacherCode);

    if (teacher != null) {
      return teacher.id!;
    }

    return insertTeacher(
      Teacher(name: teacherCode),
    );
  }

  Future<List<Teacher>> getAllTeachers() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "teacher",
      orderBy: "name",
    );

    return result.map(Teacher.fromMap).toList();
  }

  Future<List<Teacher>> searchTeachers(String query) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "teacher",
      where: "name LIKE ?",
      whereArgs: ["%$query%"],
      orderBy: "name",
    );

    return result.map(Teacher.fromMap).toList();
  }

  Future<Teacher?> getTeacherById(int id) async {

    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "teacher",
      where: "id=?",
      whereArgs: [id],
    );

    if(result.isEmpty) return null;

    return Teacher.fromMap(result.first);

  }

  Future<Teacher?> getHM() async {

    return getTeacher(
        AppConstants.hmCode,
    );

  }
}