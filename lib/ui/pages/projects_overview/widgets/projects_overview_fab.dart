part of '../projects_overview_page.dart';

class ProjectsOverviewFab extends StatefulWidget {
  const ProjectsOverviewFab({
    Key? key,
  }) : super(key: key);

  @override
  State<ProjectsOverviewFab> createState() => _ProjectsOverviewFabState();
}

class _ProjectsOverviewFabState extends State<ProjectsOverviewFab>
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
          title: " New  project ",
          iconColor: Colors.white,
          bubbleColor: Theme.of(context).primaryColor,
          icon: FontAwesomeIcons.clipboardUser,
          titleStyle: const TextStyle(fontSize: 14, color: Colors.white),
          onPress: () {
            _animationController.reverse();
            showDialog(
              context: context,
              builder: (_) => const ProjectCreateFormDialog(),
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
