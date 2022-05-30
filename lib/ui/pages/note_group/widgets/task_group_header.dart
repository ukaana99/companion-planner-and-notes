part of '../task_group_page.dart';

class TaskGroupHeader extends StatelessWidget {
  const TaskGroupHeader({Key? key, required this.taskGroup}) : super(key: key);

  final TaskGroup taskGroup;

  @override
  Widget build(BuildContext context) {
    final taskGroupColor = colorFromString(taskGroup.colorHex!);

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      height: 160,
      decoration: BoxDecoration(
        color: taskGroupColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
    
      ),
      child: Column(
        children: [
          Text(taskGroup.title ?? "No data"),
        ],
      ),
    );
  }
}
