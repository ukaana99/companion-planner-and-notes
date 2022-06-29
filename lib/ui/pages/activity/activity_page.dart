import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/activity.dart';
import '../../../data/repositories/activity_repo.dart';

import '../../../logic/bloc/activity/activity_bloc.dart';
import '../../../logic/cubit/activity/activity_cubit.dart';

import '../../../utils/helper.dart';
import '../../shared/widgets/dialog/text_dialog.dart';
import '../../shared/widgets/page_app_bar.dart';
import '../../shared/widgets/dialog/text_input.dart';
import '../../shared/widgets/dialog/form_dialog.dart';
import '../../shared/widgets/color_list_picker.dart';
import '../../shared/widgets/page_header.dart';

part 'widgets/activity_update_form_dialog.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key, required this.activity}) : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => ActivityBloc(
        activityRepository: context.read<ActivityRepository>(),
      )..add(ActivitySubscriptionRequested(activity.id!)),
      child: const ActivityView(),
    );
  }
}

class ActivityView extends StatelessWidget {
  const ActivityView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final activity = context.select((ActivityBloc bloc) => bloc.state.activity);

    return Scaffold(
      appBar: PageAppBar(
        title: "Activity",
        itemBuilder: (context) => const [
          PopupMenuItem(value: 0, child: Text('Edit')),
          PopupMenuItem(value: 1, child: Text('Delete')),
        ],
        onSelected: (item) async {
          switch (item) {
            case 0:
              showDialog(
                context: context,
                builder: (_) => ActivityUpdateFormDialog(activity: activity),
              );
              break;
            case 1:
              await showDialog(
                context: context,
                builder: (_) => TextDialog(
                  title: 'Delete activity',
                  description: 'Are you sure to delete this activity?',
                  onPressed: () =>
                      context.read<ActivityRepository>().deleteActivity(activity.id!),
                ),
              );
              break;
          }
        },
      ),
      // floatingActionButton: const ActivityOverviewFab(),

      body: NotificationListener(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            PageHeader(
              title: activity.title,
              description: activity.description,
              color: colorFromString(activity.colorHex!),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
