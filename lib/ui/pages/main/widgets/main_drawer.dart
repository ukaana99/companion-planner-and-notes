part of '../main_page.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            // ListTile(
            //   onTap: () {
            //     Navigator.pop(context);
            //     // model.navigateToMyCompanions();
            //   },
            //   leading: Icon(Icons.person),
            //   title: Text('Companions'),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.pop(context);
            //     // model.navigateToMyCommunities();
            //   },
            //   leading: Icon(Icons.group),
            //   title: Text('Communities'),
            // ),
            // ListTile(
            //   onTap: () {
            //     Navigator.pop(context);
            //     // model.navigateToSettings();
            //   },
            //   leading: Icon(Icons.settings),
            //   title: Text('Settings'),
            // ),
          ],
        ),
      ),
    );
  }
}
