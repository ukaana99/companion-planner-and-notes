import '../../models/task.dart';

abstract class TaskApi {
  const TaskApi();

  Future<Task> getTask(String id);

  Stream<Task> getTaskStream(String id);

  Future<List<Task>> getTasksByIds(List<String> ids);

  Stream<List<Task>> getTasksByGroupId(String id);

  Future<void> createTask(Task task);

  Future<void> updateTask(String id, Task task);

  Future<void> deleteTask(String id);

  Future<void> deleteTasksByGroupId(String id);
}
