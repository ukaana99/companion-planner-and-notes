part of '../main_page.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    const double size = 20.0;
    final currentIndex =
        context.select((MainCubit cubit) => cubit.state.currentIndex);

    return Container(
      color: Theme.of(context).backgroundColor,
      child: SalomonBottomBar(
        itemPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Theme.of(context).inactiveIconColor,
        currentIndex: currentIndex,
        onTap: (index) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 800), curve: Curves.ease);
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.house, size: size),
            title: const Text("Home"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.calendar, size: size),
            title: const Text(
              "Schedule",
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.chartSimple, size: size),
            title: const Text("Projects"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.listCheck, size: size),
            title: const Text("Tasks"),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.noteSticky, size: size),
            title: const Text("Notes"),
          ),
        ],
      ),
    );
  }
}
