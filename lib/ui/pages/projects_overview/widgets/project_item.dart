part of '../projects_overview_page.dart';

class ProjectListTile extends StatelessWidget {
  const ProjectListTile(
    this.project, {
    Key? key,
  }) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    final projectColor = colorFromString(project.colorHex!);

    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
       
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, AppRouter.project,
            arguments: {'project': project}),
        minVerticalPadding: 12.0,
        // tileColor: projectColor.withOpacity(0.2),
        // tileColor: Theme.of(context).backgroundOverlay,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: CircleAvatar(
          radius: 8.0,
          backgroundColor: projectColor,
        ),
        title: Text(
          project.title!,
          // style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          project.description!,
          // style: Theme.of(context).textTheme.bodyText2,
        ),
        isThreeLine: true,
      ),
    );
  }
}
