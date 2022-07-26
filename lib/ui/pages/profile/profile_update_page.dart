import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../app/app_theme.dart';
import '../../../data/models/user.dart';
import '../../../data/repositories/user_repo.dart';
import '../../../logic/cubit/user/user_cubit.dart';

import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/page_header.dart';
import '../../shared/widgets/page_item_button.dart';
import '../../shared/widgets/section_container.dart';

class ProfileUpdatePage extends StatelessWidget {
  const ProfileUpdatePage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => UserCubit(
        userRepository: context.read<UserRepository>(),
        user: user,
      ),
      child: const ProfileUpdateView(),
    );
  }
}

class ProfileUpdateView extends StatelessWidget {
  const ProfileUpdateView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((UserCubit cubit) => cubit.state);

    return Scaffold(
      appBar: PageAppBar(
        title: "Update Profile",
        itemBuilder: (context) => const [],
        onSelected: (item) async {},
        showIcon: false,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 16),
        child: PageItemButton(
          icon: FontAwesomeIcons.floppyDisk,
          title: 'Save profile',
          onPressed: () async {
            await context.read<UserCubit>().updateForm();
            Navigator.of(context).pop();
          },
        ),
      ),
      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
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
              title: state.user!.displayName,
              description: state.user!.email,
            ),
            SectionContainer(
                title: 'UID', child: _ListItem(title: state.user!.id!)),
            SectionContainer(
                title: 'Name', child: _TextInput(name: state.displayName)),
            SectionContainer(
                title: 'E-mail', child: _ListItem(title: state.user!.email!)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: TextFormField(
        initialValue: name,
        onChanged: context.read<UserCubit>().displayNameChanged,
        cursorColor: Theme.of(context).primaryColor,
        style: TextStyle(color: Theme.of(context).textColor),
        decoration: const InputDecoration(
          focusedBorder: InputBorder.none,
          border: InputBorder.none,
          hintText: 'Untitled',
          isDense: true,
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
          style: TextStyle(color: Theme.of(context).hintColor),
        ),
      ),
    );
  }
}
