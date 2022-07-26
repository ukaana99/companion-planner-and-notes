import '../models/task_group.dart';
import '../providers/task/task_group_api.dart';

class TaskGroupRepository {
  final TaskGroupApi _taskGroupApi;

  const TaskGroupRepository({
    required TaskGroupApi taskGroupApi,
  }) : _taskGroupApi = taskGroupApi;

  Future<TaskGroup> getTaskGroup(String id) => _taskGroupApi.getTaskGroup(id);

  Stream<TaskGroup> getTaskGroupStream(String id) =>
      _taskGroupApi.getTaskGroupStream(id);

  Future<List<TaskGroup>> getTaskGroupsByIds(List<String> ids) =>
      _taskGroupApi.getTaskGroupsByIds(ids);

  Stream<List<TaskGroup>> getTaskGroupsByUserId(String userId) =>
      _taskGroupApi.getTaskGroupsByUserId(userId);

  Stream<List<TaskGroup>> getTaskGroupsByProjectId(String projectId) =>
      _taskGroupApi.getTaskGroupsByProjectId(projectId);

  // Stream<List<TaskGroup>> getPendingTaskGroups(String userId) =>
  //     _taskGroupApi.getPendingTaskGroups(userId);

  // Stream<List<TaskGroup>> getDoneTaskGroups(String userId) =>
  //     _taskGroupApi.getDoneTaskGroups(userId);

  Future<void> createTaskGroup(TaskGroup taskgroup) =>
      _taskGroupApi.createTaskGroup(taskgroup);

  Future<void> updateTaskGroup(String id, TaskGroup taskgroup) =>
      _taskGroupApi.updateTaskGroup(id, taskgroup);

  Future<void> deleteTaskGroup(String id) => _taskGroupApi.deleteTaskGroup(id);
}
