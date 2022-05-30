part of '../project_page.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final projectColor = colorFromString(project.colorHex!);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: projectColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
       
      ),
      child: Column(
        children: [
          Text(project.title ?? "No data"),
        ],
      ),
    );
  }
}
