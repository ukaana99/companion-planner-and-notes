import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../../app/app_theme.dart';
import '../../../app/app_router.dart';
import '../../../data/models/note_group.dart';
import '../../../data/repositories/note_group_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/note_groups_overview/note_groups_overview_bloc.dart';
import '../../../logic/cubit/note_group/note_group_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/no_data_placeholder.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/search_bar.dart';

part 'widgets/note_groups_overview_fab.dart';
part 'widgets/note_group_create_form_dialog.dart';
part 'widgets/note_group_item.dart';

class NoteGroupsOverviewPage extends StatelessWidget {
  const NoteGroupsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocProvider(
      lazy: false,
      create: (context) => NoteGroupsOverviewBloc(
        noteGroupRepository: context.read<NoteGroupRepository>(),
      )..add(NoteGroupsOverviewSubscriptionRequested(user.id!)),
      child: const NoteGroupsOverviewView(),
    );
  }
}

class NoteGroupsOverviewView extends StatelessWidget {
  const NoteGroupsOverviewView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((NoteGroupsOverviewBloc bloc) => bloc.state);

    return Scaffold(
      appBar: const SearchBar(),
      floatingActionButton: const NoteGroupsOverviewFab(),
      body: state.noteGroups.isEmpty
          ? SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(top: kToolbarHeight * 2),
                  child: NoDataPlaceholder(
                    Theme.of(context).brightness == Brightness.light
                        ? 'assets/svg/note_1.svg'
                        : 'assets/svg/note_2.svg',
                    title: 'No notes available',
                    description: 'Try creating a new note first',
                    isLoading: state.status == NoteGroupsOverviewStatus.loading,
                  ),
                ),
              ),
            )
          : ListView(
              children: [
                const SizedBox(height: 8),
                for (var noteGroup in state.noteGroups)
                  NoteGroupListTile(noteGroup),
                const SizedBox(height: 16),
              ],
            ),
    );
  }
}
