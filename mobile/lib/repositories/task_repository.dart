import '../core/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';
import '../core/constants/task_status.dart';

class TaskRepository {

  Future<List<Task>> pendingTasks() async {

  final db = await DatabaseHelper.instance.database;

  final result = await db.query(
      "task",
      where: "status=?",
      whereArgs: ["PENDING"],
      orderBy: "period",
  );

  return result
      .map((e)=>Task.fromMap(e))
      .toList();

}

  Future<void> assignTeacher({
    required int taskId,
    required int teacherId,
  }) async {
    final db = await DatabaseHelper.instance.database;

    await db.update(
      "task",
      {
        "assignedTeacherId": teacherId,
        "status": "ASSIGNED",
      },
      where: "id=?",
      whereArgs: [taskId],
    );
  }

  Future<List<Task>> getAssignedTasks({
    required int day,
    required int period,
    }) async {

    final db = await DatabaseHelper.instance.database;

    final result = await db.query(
        "task",
        where: "day=? AND period=? AND status=?",
        whereArgs: [
        day,
        period,
        "ASSIGNED",
        ],
    );

    return result
        .map((e) => Task.fromMap(e))
        .toList();
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

        final db =
            await DatabaseHelper.instance.database;

        final result =
            await db.rawQuery("""

        SELECT COUNT(*)

        FROM task

        WHERE status=?

        """,[
            TaskStatus.pending,
        ]);

        return Sqflite.firstIntValue(result) ?? 0;

        }
}