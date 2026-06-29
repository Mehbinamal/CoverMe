import '../core/constants/task_status.dart';
import '../repositories/task_repository.dart';

class AssignmentService {
  final TaskRepository taskRepository =
      TaskRepository();

  Future<void> assignTeacher({
    required int taskId,
    required int teacherId,
  }) async {
    await taskRepository.assignTeacher(
      taskId: taskId,
      teacherId: teacherId,
    );
  }
}