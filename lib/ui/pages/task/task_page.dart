// import 'package:companion/ui/shared/widgets/section_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// import '../../../app/app_theme.dart';
// import '../../../data/models/task.dart';
// import '../../../data/repositories/task_repo.dart';
// import '../../../logic/cubit/task/task_cubit.dart';
// import '../../../logic/bloc/task/task_bloc.dart';

// import '../../../utils/helper.dart';
// import '../../shared/widgets/page_app_bar.dart';
// import '../../shared/widgets/text_input.dart';
// import '../../shared/widgets/color_list_picker.dart';
// import '../../shared/widgets/dialog/form_dialog.dart';

// part 'widgets/task_header.dart';
// part 'widgets/task_update_form_dialog.dart';

// class TaskPage extends StatelessWidget {
//   const TaskPage({Key? key, required this.task}) : super(key: key);

//   final Task task;

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       lazy: false,
//       create: (context) => TaskBloc(
//         taskRepository: context.read<TaskRepository>(),
//       )..add(TaskSubscriptionRequested(task.id!)),
//       child: const TaskView(),
//     );
//   }
// }

// class TaskView extends StatelessWidget {
//   const TaskView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final state = context.select((TaskBloc bloc) => bloc.state);

//     return Scaffold(
//       appBar: PageAppBar(
//         title: "Task",
//         itemBuilder: (context) => const [
//           PopupMenuItem(child: Text('Edit'), value: 0),
//         ],
//         onSelected: (item) {
//           switch (item) {
//             case 0:
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) =>
//                     TaskUpdateFormDialog(task: state.task),
//               );
//           }
//         },
//       ),
//       body: NotificationListener(
//         onNotification: (OverscrollIndicatorNotification overscroll) {
//           overscroll.disallowIndicator();
//           return true;
//         },
//         child: ListView(
//           children: [
//             TaskHeader(task: state.task),
//             const SectionContainer(title: 'Tasks', child: _TaskTasks()),
//             const SectionContainer(title: 'Notes', child: _TaskNotes()),
//             const SizedBox(height: 40),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _TaskTasks extends StatelessWidget {
//   const _TaskTasks({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const [
//         _TaskTaskItem(title: 'Task 1'),
//         _TaskTaskItem(title: 'Task 2'),
//       ],
//     );
//   }
// }

// class _TaskNotes extends StatelessWidget {
//   const _TaskNotes({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: const [
//         _TaskNoteItem(title: 'Note 1'),
//         _TaskNoteItem(title: 'Note 2'),
//       ],
//     );
//   }
// }

// class _TaskTaskItem extends StatelessWidget {
//   const _TaskTaskItem({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).backgroundOverlay,
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       child: SizedBox.expand(child: Text(title)),
//     );
//   }
// }

// class _TaskNoteItem extends StatelessWidget {
//   const _TaskNoteItem({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   final String title;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 48,
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Theme.of(context).backgroundOverlay,
//         borderRadius: const BorderRadius.all(Radius.circular(16)),
//       ),
//       child: SizedBox.expand(child: Text(title)),
//     );
//   }
// }
