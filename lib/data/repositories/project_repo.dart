import '../models/project.dart';
import '../providers/project/project_api.dart';

class ProjectRepository {
  final ProjectApi _projectApi;

  const ProjectRepository({
    required ProjectApi projectApi,
  }) : _projectApi = projectApi;

  Future<Project> getProject(String id) => _projectApi.getProject(id);

  Stream<Project> getProjectStream(String id) =>
      _projectApi.getProjectStream(id);

  Future<List<Project>> getProjectsByIds(List<String> ids) =>
      _projectApi.getProjectsByIds(ids);

  Stream<List<Project>> getProjectsByUserId(String userId) =>
      _projectApi.getProjectsByUserId(userId);

  Future<void> createProject(Project project) =>
      _projectApi.createProject(project);

  Future<void> updateProject(String id, Project project) =>
      _projectApi.updateProject(id, project);

  Future<void> deleteProject(String id) => _projectApi.deleteProject(id);
}
