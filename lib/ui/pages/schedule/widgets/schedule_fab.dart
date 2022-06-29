part of '../schedule_page.dart';

class ScheduleFab extends StatefulWidget {
  const ScheduleFab({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleFab> createState() => _ScheduleFabState();
}

class _ScheduleFabState extends State<ScheduleFab>
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
          title: "New activity",
          iconColor: Colors.white,
          bubbleColor: Theme.of(context).primaryColor,
          icon: FontAwesomeIcons.clipboardQuestion,
          titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
          onPress: () {
            _animationController.reverse();
            showDialog(
              context: context,
              builder: (_) => BlocProvider.value(
                value: context.read<ScheduleBloc>(),
                child: const ActivityCreateFormDialog(),
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
