import '../repositories/task_repository.dart';

class AssignmentService {
  final TaskRepository _taskRepository = TaskRepository();

  /// Assign a substitute teacher to a task
  Future<void> assignTeacher({
    required int taskId,
    required int teacherId,
  }) async {
    await _taskRepository.assignTeacher(taskId: taskId, teacherId: teacherId);
  }

  Future<void> removeAssignment({required int taskId}) async {
    await _taskRepository.unassignTask(taskId);
  }
}
