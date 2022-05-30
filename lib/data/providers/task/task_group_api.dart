import '../../models/task_group.dart';

abstract class TaskGroupApi {
  const TaskGroupApi();

  Future<TaskGroup> getTaskGroup(String id);

  Stream<TaskGroup> getTaskGroupStream(String id);

  Future<List<TaskGroup>> getTaskGroupsByIds(List<String> ids);

  Stream<List<TaskGroup>> getTaskGroupsByUserId(String id);

  // Stream<List<TaskGroup>> getPendingTaskGroups(String id);

  // Stream<List<TaskGroup>> getDoneTaskGroups(String id);
  
  Stream<List<TaskGroup>> getTaskGroupsByProjectId(String id);

  Future<void> createTaskGroup(TaskGroup taskGroup);

  Future<void> updateTaskGroup(String id, TaskGroup taskGroup);

  Future<void> deleteTaskGroup(String id);
}
