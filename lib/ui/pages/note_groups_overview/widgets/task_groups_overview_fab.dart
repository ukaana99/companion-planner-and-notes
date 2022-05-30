part of '../task_groups_overview_page.dart';

class TaskGroupOverviewFab extends StatefulWidget {
  const TaskGroupOverviewFab({
    Key? key,
  }) : super(key: key);

  @override
  State<TaskGroupOverviewFab> createState() => _TaskGroupOverviewFabState();
}

class _TaskGroupOverviewFabState extends State<TaskGroupOverviewFab>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionBubble(
      items: <Bubble>[
        Bubble(
          title: "New group",
          iconColor: Colors.white,
          bubbleColor: Theme.of(context).primaryColor,
          icon: FontAwesomeIcons.clipboardList,
          titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
          onPress: () {
            _animationController.reverse();
            showDialog(
              context: context,
              builder: (_) => const TaskGroupCreateFormDialog(),
            );
          },
        ),
        Bubble(
          title: " New  task ",
          iconColor: Colors.white,
          bubbleColor: Theme.of(context).primaryColor,
          icon: FontAwesomeIcons.clipboardCheck,
          titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
          onPress: () {
            _animationController.reverse();
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<TaskGroupsOverviewBloc>(),
                child: const TaskCreateFormDialog(),
              ),
            );
          },
        ),
      ],
      animation: _animation,
      onPress: () => _animationController.isCompleted
          ? _animationController.reverse()
          : _animationController.forward(),
      iconColor: Colors.white,
      iconData: FontAwesomeIcons.plus,
      backGroundColor: Theme.of(context).primaryColor,
    );
  }
}
