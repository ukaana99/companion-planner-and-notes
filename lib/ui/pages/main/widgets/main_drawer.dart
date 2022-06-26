part of '../main_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select((MainCubit cubit) => cubit.state.currentIndex);

    _buildListTile() {
      final pages = [
        {"index": 0, "title": "Home", "icon": FontAwesomeIcons.house},
        {"index": 1, "title": "Schedule", "icon": FontAwesomeIcons.calendar},
        {"index": 2, "title": "Projects", "icon": FontAwesomeIcons.chartSimple},
        {"index": 3, "title": "Tasks", "icon": FontAwesomeIcons.listCheck},
        {"index": 4, "title": "Notes", "icon": FontAwesomeIcons.noteSticky},
      ];

      return pages
          .map(
            (page) => ListTile(
              onTap: () {
                pageController.animateToPage(page["index"] as int,
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.ease);

                Navigator.pop(context);
              },
              leading: Icon(
                page["icon"] as IconData,
                color: Theme.of(context).hintColor,
              ),
              title: Text(page["title"] as String),
            ),
          )
          .toList();
    }

    return Drawer(
      child: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: UserAccountsDrawerHeader(
                decoration: const BoxDecoration(),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    // model.navigateToProfile();
                  },
                  child: CircleAvatar(
                    child: Theme.of(context).brightness == Brightness.light
                        ? Image.asset('assets/icons/companion1.png')
                        : Image.asset('assets/icons/companion2.png'),
                  ),
                ),
                accountName: Text(
                  "displayName",
                  style: TextStyle(
                    color: Theme.of(context).backgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: const Text(
                  "u/username",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ..._buildListTile(),
          ],
        ),
      ),
    );
  }
}
