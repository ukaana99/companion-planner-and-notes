part of '../home_page.dart';

class HomeTasks extends StatelessWidget {
  const HomeTasks({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Text(
              "Tasks",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          const _HomeTaskItem(title: "Task 1"),
          const _HomeTaskItem(title: "Task 2"),
        ],
      ),
    );
  }
}

class _HomeTaskItem extends StatelessWidget {
  const _HomeTaskItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: SizedBox.expand(child: Text(title)),
    );
  }
}
