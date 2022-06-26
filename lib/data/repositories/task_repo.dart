import '../models/task.dart';
import '../providers/task/task_api.dart';

class TaskRepository {
  final TaskApi _taskApi;

  const TaskRepository({
    required TaskApi taskApi,
  }) : _taskApi = taskApi;

  Future<Task> getTask(String id) => _taskApi.getTask(id);

  Stream<Task> getTaskStream(String id) =>
      _taskApi.getTaskStream(id);
      
  Future<List<Task>> getTasksByIds(List<String> ids) =>
      _taskApi.getTasksByIds(ids);

  Stream<List<Task>> getTasksByGroupId(String userId) =>
      _taskApi.getTasksByGroupId(userId);

  Future<void> createTask(Task task) => _taskApi.createTask(task);

  Future<void> updateTask(String id, Task task) =>
      _taskApi.updateTask(id, task);

  Future<void> deleteTask(String id) => _taskApi.deleteTask(id);
  
  Future<void> deleteTasksByGroupId(String id) =>
      _taskApi.deleteTasksByGroupId(id);
}
