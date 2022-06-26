part of '../main_page.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final titles = ["Welcome back!", "Schedule", "Projects", "Tasks", "Notes"];
    final currentIndex =
        context.select((MainCubit cubit) => cubit.state.currentIndex);

    return AppBar(
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        icon: const Icon(FontAwesomeIcons.bars),
        onPressed: () {
          scaffoldKey.currentState!.openDrawer();
          // _controller.text = "";
          // model.useSearch(false);
        },
      ),
      title: false
          // ignore: dead_code
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundOverlay,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              child: TextField(
                // controller: _controller,
                // onTap: () => model.useSearch(true),
                style: TextStyle(
                  color: Theme.of(context).textColor,
                ),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: "Search",
                  isDense: true,
                  icon: Icon(
                    Icons.search,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
            )
          : Text(
              titles[currentIndex],
            ),
      actions: [
        Container(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: null,
            child: CircleAvatar(
              child: Theme.of(context).brightness == Brightness.light
                  ? Image.asset('assets/icons/companion1.png')
                  : Image.asset('assets/icons/companion2.png'),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
