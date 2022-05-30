import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/models/project.dart';
import '../../../data/repositories/project_repo.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  ProjectBloc({
    required ProjectRepository projectRepository,
  })  : _projectRepository = projectRepository,
        super(const ProjectState()) {
    on<ProjectSubscriptionRequested>(_onSubscriptionRequested);
  }

  final ProjectRepository _projectRepository;

  Future<void> _onSubscriptionRequested(event, emit) async {
    emit(state.copyWith(status: ProjectStatus.loading));

    await emit.forEach<Project>(
      _projectRepository.getProjectStream(event.id),
      onData: (project) => state.copyWith(
        status: ProjectStatus.success,
        project: project,
      ),
      onError: (_, __) => state.copyWith(
        status: ProjectStatus.failure,
      ),
    );
  }
}
