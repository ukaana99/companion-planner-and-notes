import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repo.dart';
import '../../../logic/bloc/user/user_bloc.dart';

import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/page_item_button.dart';
import '../../shared/widgets/section_container.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => UserBloc(
        userRepository: context.read<UserRepository>(),
      )..add(UserSubscriptionRequested(user.id!)),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((UserBloc bloc) => bloc.state.user);
    final status = context.select((UserBloc bloc) => bloc.state.status);

    return Scaffold(
      appBar: PageAppBar(
        title: "Profile",
        itemBuilder: (context) => const [],
        onSelected: (item) async {},
        showIcon: false,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: PageItemButton(
          icon: FontAwesomeIcons.penToSquare,
          title: 'Update profile',
          onPressed: () => Navigator.of(context)
              .pushNamed(AppRouter.profileUpdate, arguments: {'user': user}),
        ),
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: status != UserStatus.success
            ? Container()
            : ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16),
                    child: CircleAvatar(
                      radius: 48,
                      child: Theme.of(context).brightness == Brightness.light
                          ? Image.asset('assets/icons/companion1.png')
                          : Image.asset('assets/icons/companion2.png'),
                    ),
                  ),
                  PageHeader(
                    title: user.displayName,
                    description: user.email,
                  ),
                  SectionContainer(
                      title: 'UID', child: _ListItem(title: user.id!)),
                  SectionContainer(
                      title: 'Name',
                      child: _ListItem(title: user.displayName!)),
                  SectionContainer(
                      title: 'E-mail', child: _ListItem(title: user.email!)),
                  const SizedBox(height: 40),
                ],
              ),
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  const _ListItem({
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
      child: SizedBox.expand(
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).textColor),
        ),
      ),
    );
  }
}
