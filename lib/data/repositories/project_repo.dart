import '../models/project.dart';
import '../providers/project/project_api.dart';

class ProjectRepository {
  final ProjectApi _projectApi;

  const ProjectRepository({
    required ProjectApi projectApi,
  }) : _projectApi = projectApi;

  Stream<List<Project>> getProjects(String userId) => _projectApi.getProjectsByUserId(userId);

  Future<void> createProject(Project project) => _projectApi.createProject(project);

  Future<void> deleteProject(String id) => _projectApi.deleteProject(id);
}
