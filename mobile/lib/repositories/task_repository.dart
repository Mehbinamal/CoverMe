import '../core/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
import '../core/constants/task_status.dart';

class TaskRepository {
  Future<List<Task>> getPendingTasks({required String date}) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "task",
      where: "status=? AND date=?",
      whereArgs: [TaskStatus.pending, date],
      orderBy: "period",
    );

    return result.map(Task.fromMap).toList();
  }

  Future<void> assignTeacher({
    required int taskId,
    required int teacherId,
  }) async {
    final db = await DatabaseHelper.instance.database;

    await db.update(
      "task",
      {"assignedTeacherId": teacherId, "status": "ASSIGNED"},
      where: "id=?",
      whereArgs: [taskId],
    );
  }

  Future<List<Task>> getAssignedTasks({required String date}) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "task",

      where: "status=? AND date=?",

      whereArgs: [TaskStatus.assigned, date],

      orderBy: "period",
    );

    return result.map(Task.fromMap).toList();
  }

  Future<void> createTask(Task task) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(
      "task",
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  Future<int> pendingCount() async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.rawQuery(
      """

        SELECT COUNT(*)

        FROM task

        WHERE status=?

        """,
      [TaskStatus.pending],
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> deleteTasksForLeave({
    required int teacherId,
    required String date,
  }) async {
    final db = await DatabaseHelper.instance.database;

    await db.delete(
      "task",
      where: "teacherId=? AND date=?",
      whereArgs: [teacherId, date],
    );
  }

  Future<bool> isTeacherAssigned({
    required int teacherId,
    required String date,
    required int period,
  }) async {
    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
      "task",
      where: "assignedTeacherId=? AND date=? AND period=?",
      whereArgs: [teacherId, date, period],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<void> unassignTask(int taskId) async {
    final db = await DatabaseHelper.instance.database;

    await db.update(
      "task",
      {"assignedTeacherId": null, "status": TaskStatus.pending},
      where: "id=?",
      whereArgs: [taskId],
    );
  }

  Future<void> deleteOldTasks() async {
    final db = await DatabaseHelper.instance.database;

    final today = DateTime.now().toIso8601String().split('T').first;

    await db.delete("task", where: "date < ?", whereArgs: [today]);
  }

  Future<void> deleteTasksForDate(String date) async {
    final db = await DatabaseHelper.instance.database;

    await db.delete("task", where: "date = ?", whereArgs: [date]);
  }

  Future<void> deleteAllTasks() async {
    final db = await DatabaseHelper.instance.database;

    await db.delete("task");
  }
}
