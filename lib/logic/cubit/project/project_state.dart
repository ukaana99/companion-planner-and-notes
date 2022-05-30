part of 'project_cubit.dart';

class ProjectState extends Equatable {
  final Project? project;
  final String title;
  final String coordinator;
  final String description;
  final String colorHex;

  const ProjectState({
    this.project,
    this.title = '',
    this.coordinator = '',
    this.description = '',
    this.colorHex = '',
  });

  @override
  List<Object> get props => [title, coordinator, description, colorHex];

  ProjectState copyWith({
    Project? project,
    String? title,
    String? coordinator,
    String? description,
    String? colorHex,
  }) {
    return ProjectState(
      project:project?? this.project,
      title: title ?? this.title,
      coordinator: coordinator ?? this.coordinator,
      description: description ?? this.description,
      colorHex: colorHex ?? this.colorHex,
    );
  }
}
