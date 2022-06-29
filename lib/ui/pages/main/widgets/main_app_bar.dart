part of '../main_page.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppBar({
    Key? key,
    required this.scaffoldKey,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    final currentIndex =
        context.select((MainCubit cubit) => cubit.state.currentIndex);
    final user = context.select((UserBloc bloc) => bloc.state.user);

    final titles = [
      "Welcome ${user.displayName!}!",
      "Schedule",
      "Projects",
      "Tasks",
      "Notes"
    ];

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
      title: Text(titles[currentIndex]),
      actions: [
        Container(
          padding: const EdgeInsets.all(12.0),
          child: GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(AppRouter.profile, arguments: {'user': user}),
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
