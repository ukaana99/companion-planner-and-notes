import '../../models/project.dart';

abstract class ProjectApi {
  const ProjectApi();

  Future<Project> getProject(String id);

  Stream<Project> getProjectStream(String id);

  Future<List<Project>> getProjectsByIds(List<String> ids);

  Stream<List<Project>> getProjectsByUserId(String id);

  Future<void> createProject(Project project);

  Future<void> updateProject(String id, Project project);

  Future<void> deleteProject(String id);
}
