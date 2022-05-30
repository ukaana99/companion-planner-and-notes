import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/project.dart';
import '../../../data/repositories/project_repo.dart';

part 'project_state.dart';

class ProjectCubit extends Cubit<ProjectState> {
  ProjectCubit({
    this.project,
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(ProjectState(
          project: project,
          title: project?.title ?? '',
          description: project?.description ?? '',
          coordinator: project?.coordinator ?? '',
          colorHex: project?.colorHex ?? '0xffffffff',
        ));

  final ProjectRepository _projectRepository;
  final Project? project;

  void titleChanged(String value) => emit(state.copyWith(title: value));

  void coordinatorChanged(String value) =>
      emit(state.copyWith(coordinator: value));

  void descriptionChanged(String value) =>
      emit(state.copyWith(description: value));

  void colorChanged(String value) => emit(state.copyWith(colorHex: value));

  Future<void> submitForm(String userId) async {
    final project = Project(
      title: state.title,
      coordinator: state.coordinator,
      description: state.description,
      colorHex: state.colorHex,
      userId: userId,
    );
    try {
      await _projectRepository.createProject(project);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }

  Future<void> updateForm() async {
    final project = state.project?.copyWith(
      title: state.title,
      coordinator: state.coordinator,
      description: state.description,
      colorHex: state.colorHex,
    );
    try {
      await _projectRepository.updateProject(state.project!.id!, project!);
      // emit(state.copyWith(status: "Success"));
    } catch (_) {
      // emit(state.copyWith(status: "Error"));
    }
  }
}
