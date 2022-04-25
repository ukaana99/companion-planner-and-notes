import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/project.dart';
import '../../../data/repositories/auth_repo.dart';
import '../../../data/repositories/project_repo.dart';

part 'projects_overview_event.dart';
part 'projects_overview_state.dart';

class ProjectsOverviewBloc
    extends Bloc<ProjectsOverviewEvent, ProjectsOverviewState> {
  ProjectsOverviewBloc({
    required AuthRepository authRepository,
    required ProjectRepository projectRepository,
  })  : _authRepository = authRepository,
        _projectRepository = projectRepository,
        super(const ProjectsOverviewState()) {
    on<ProjectsOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<ProjectsOverviewProjectDeleted>(_onProjectDeleted);
    on<ProjectsOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
  }

  final AuthRepository _authRepository;
  final ProjectRepository _projectRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: () => ProjectsOverviewStatus.loading));

    await emit.forEach<List<Project>>(
      _projectRepository.getProjects(_authRepository.currentUser.id),
      onData: (projects) => state.copyWith(
        status: () => ProjectsOverviewStatus.success,
        projects: () => projects,
      ),
      onError: (_, __) => state.copyWith(
        status: () => ProjectsOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onProjectDeleted(event, emit) async {
    emit(state.copyWith(lastDeletedProject: () => event.project));
    await _projectRepository.deleteProject(event.project.id);
  }

  Future<void> _onUndoDeletionRequested(event, emit) async {
    assert(
      state.lastDeletedProject != null,
      'Last deleted project can not be null.',
    );

    final project = state.lastDeletedProject!;
    emit(state.copyWith(lastDeletedProject: () => null));
    await _projectRepository.createProject(project);
  }
}
