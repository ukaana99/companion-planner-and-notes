import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:floating_action_bubble/floating_action_bubble.dart';

import '../../../app/app_router.dart';
import '../../../app/app_theme.dart';
import '../../../data/models/activity.dart';
import '../../../data/repositories/activity_repo.dart';
import '../../../data/repositories/project_repo.dart';

import '../../../logic/bloc/app/app_bloc.dart';
import '../../../logic/bloc/schedule/schedule_bloc.dart';
import '../../../logic/cubit/activity/activity_cubit.dart';

import '../../../logic/cubit/schedule/schedule_cubit.dart';
import '../../../utils/helper.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/dialog/date_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/dialog/selection_input.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/time_input.dart';
import '../../shared/widgets/dialog/toggle_input.dart';

part 'widgets/schedule_fab.dart';
part 'widgets/schedule_day.dart';
part 'widgets/activity_create_form_dialog.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ScheduleBloc>(
          lazy: false,
          create: (context) => ScheduleBloc(
            activityRepository: context.read<ActivityRepository>(),
            projectRepository: context.read<ProjectRepository>(),
          ),
        ),
        BlocProvider<ScheduleCubit>(
          create: (context) => ScheduleCubit(),
        ),
      ],
      child: const ScheduleView(),
    );
  }
}

class ScheduleView extends StatelessWidget {
  const ScheduleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final currentDate =
        context.select((ScheduleCubit cubit) => cubit.state.currentDate);
    final dateTime =
        DateTime(currentDate.year, currentDate.month, currentDate.day);

    context.read<ScheduleBloc>()
      ..add(ScheduleActivitiesSubscriptionRequested(user.id!, dateTime))
      ..add(ScheduleProjectsSubscriptionRequested(user.id!));

    return const Scaffold(
      floatingActionButton: ScheduleFab(),
      body: Scaffold(
        appBar: ScheduleDayPicker(),
        body: ScheduleDayList(),
      ),
    );
  }
}
