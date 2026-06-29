import '../core/database/database_helper.dart';

class TaskRepository {
  Future<void> createTask(
      Map<String, dynamic> task) async {
    final db = await DatabaseHelper.instance.database;

    await db.insert(
      "task",
      task,
    );
  }

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
}