import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../../app/app_theme.dart';
import '../../../app/app_router.dart';
import '../../../data/models/task_group.dart';
import '../../../data/repositories/task_repo.dart';
import '../../../data/repositories/task_group_repo.dart';
import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/task_group_overview/task_groups_overview_bloc.dart';
import '../../../logic/cubit/task/task_cubit.dart';
import '../../../logic/cubit/task_group/task_group_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/no_data_placeholder.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/date_input.dart';
import '../../shared/widgets/dialog/time_input.dart';
import '../../shared/widgets/dialog/selection_input.dart';


part 'widgets/task_groups_overview_fab.dart';
part 'widgets/task_group_create_form_dialog.dart';
part 'widgets/task_create_form_dialog.dart';
part 'widgets/task_group_item.dart';

class TaskGroupsOverviewPage extends StatelessWidget {
  const TaskGroupsOverviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return BlocProvider(
      lazy: false,
      create: (context) => TaskGroupsOverviewBloc(
        taskGroupRepository: context.read<TaskGroupRepository>(),
      )..add(TaskGroupsOverviewSubscriptionRequested(user.id!)),
      child: const TaskGroupOverviewView(),
    );
  }
}

class TaskGroupOverviewView extends StatelessWidget {
  const TaskGroupOverviewView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((TaskGroupsOverviewBloc bloc) => bloc.state);
    final pendingTaskGroups =
        state.taskGroups.where((i) => i.completion != 100).toList();
    final doneTaskGroups =
        state.taskGroups.where((i) => i.completion == 100).toList();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: TabBar(
            tabs: const [Tab(text: 'Pending'), Tab(text: 'Done')],
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Theme.of(context).hintColor,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
          ),
        ),
        floatingActionButton: const TaskGroupOverviewFab(),
        body: TabBarView(
          children: [
            pendingTaskGroups.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: kToolbarHeight),
                        child: NoDataPlaceholder(
                          Theme.of(context).brightness == Brightness.light
                              ? 'assets/svg/no_data_1.svg'
                              : 'assets/svg/no_data_2.svg',
                          title: 'No pending task',
                          description: 'Try creating a new task or task group',
                          isLoading:
                              state.status == TaskGroupsOverviewStatus.loading,
                        ),
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      const SizedBox(height: 8),
                      for (var taskGroup in pendingTaskGroups)
                        TaskGroupListTile(taskGroup),
                      const SizedBox(height: 40),
                    ],
                  ),
            doneTaskGroups.isEmpty
                ? SingleChildScrollView(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.only(top: kToolbarHeight),
                        child: NoDataPlaceholder(
                          Theme.of(context).brightness == Brightness.light
                              ? 'assets/svg/no_data_1.svg'
                              : 'assets/svg/no_data_2.svg',
                          title: 'No task is is done',
                          description: 'You need to complete at least one task',
                          isLoading:
                              state.status == TaskGroupsOverviewStatus.loading,
                        ),
                      ),
                    ),
                  )
                : ListView(
                    children: [
                      const SizedBox(height: 8),
                      for (var taskGroup in doneTaskGroups)
                        TaskGroupListTile(taskGroup),
                      const SizedBox(height: 40),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
