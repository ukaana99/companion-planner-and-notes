part of '../task_groups_overview_page.dart';

class TaskGroupListTile extends StatelessWidget {
  const TaskGroupListTile(
    this.taskGroup, {
    Key? key,
  }) : super(key: key);

  final TaskGroup taskGroup;

  Color getCompletionColor(int completion) {
    var red = (completion > 50 ? 1 - 2 * (completion - 50) / 100.0 : 1.0) * 255;
    var green = (completion > 50 ? 1.0 : 2 * completion / 100.0) * 191;
    Color result = Color.fromARGB(255, red.toInt(), green.toInt(), 0);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final taskGroupColor = colorFromString(taskGroup.colorHex!);

    return Container(
      // height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, AppRouter.taskGroup,
            arguments: {'taskGroup': taskGroup}),
        minVerticalPadding: 12.0,
        // tileColor: taskGroupColor.withOpacity(0.2),
        // tileColor: Theme.of(context).backgroundOverlay,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: CircleAvatar(
          radius: 8.0,
          backgroundColor: taskGroupColor,
        ),
        trailing: Container(
          margin: const EdgeInsets.all(8),
          width: 60,
          decoration: BoxDecoration(
            color: getCompletionColor(taskGroup.completion!),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              '${taskGroup.completion}%',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        title: Text(
          taskGroup.title!.isNotEmpty ? taskGroup.title! : 'Untitled',
          // style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          taskGroup.description!.isNotEmpty
              ? taskGroup.description!
              : 'No description available',
          // style: Theme.of(context).textTheme.bodyText2,
        ),
        isThreeLine: true,
      ),
    );
  }
}
