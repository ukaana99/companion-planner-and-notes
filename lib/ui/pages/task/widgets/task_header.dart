// part of '../task_page.dart';

// class TaskHeader extends StatelessWidget {
//   const TaskHeader({Key? key, required this.task}) : super(key: key);

//   final Task task;

//   @override
//   Widget build(BuildContext context) {
//     final taskColor = colorFromString(task.colorHex!);

//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//       padding: const EdgeInsets.all(16),
//       height: 160,
//       decoration: BoxDecoration(
//         color: taskColor,
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       child: Column(
//         children: [
//           Text(task.title ?? "No data"),
//         ],
//       ),
//     );
//   }
// }
