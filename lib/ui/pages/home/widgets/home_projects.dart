part of '../home_page.dart';

class HomeProjects extends StatelessWidget {
  const HomeProjects({
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
              "Projects",
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _HomeProjectItem(color: Theme.of(context).primaryColor),
                    _HomeProjectItem(color: Theme.of(context).secondaryColor),
                    _HomeProjectItem(color: Theme.of(context).tertiaryColor),
                    _HomeProjectItem(color: Theme.of(context).quaternaryColor),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeProjectItem extends StatelessWidget {
  const _HomeProjectItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
    );
  }
}
