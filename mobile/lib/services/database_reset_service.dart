import '../repositories/leave_repository.dart';
import '../repositories/task_repository.dart';

class DatabaseResetService {
  final LeaveRepository _leaveRepository = LeaveRepository();
  final TaskRepository _taskRepository = TaskRepository();

  Future<void> reset() async {
    await _leaveRepository.deleteAllLeaves();
    await _taskRepository.deleteAllTasks();
  }
}