part of '../schedule_page.dart';

class ActivityCreateFormDialog extends StatelessWidget {
  const ActivityCreateFormDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityCubit(
        activityRepository: context.read<ActivityRepository>(),
      ),
      child: const ActivityCreateFormDialogView(),
    );
  }
}

class ActivityCreateFormDialogView extends StatelessWidget {
  const ActivityCreateFormDialogView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    final projects = context.select((ScheduleBloc bloc) => bloc.state.projects);
    final selectedColor =
        context.select((ActivityCubit cubit) => cubit.state.colorHex);

    final state = context.select((ActivityCubit cubit) => cubit.state);

    return FormDialog(
      title: "New activity",
      confirmLabel: "Add",
      onPressed: () => context.read<ActivityCubit>().submitForm(user.id!),
      children: [
        const SizedBox(height: 12),
        TextInput(
          hintText: 'Title',
          onChanged: context.read<ActivityCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          hintText: 'Description',
          onChanged: context.read<ActivityCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ToggleInput(
          value: state.isRepeated,
          hintText: 'Repeat',
          onChanged: context.read<ActivityCubit>().isRepeatedChanged,
        ),
        const SizedBox(height: 8),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ToggleButtons(
            textStyle: TextStyle(color: Theme.of(context).hintColor),
            isSelected: state.daysRepeated,
            onPressed: state.isRepeated
                ? context.read<ActivityCubit>().daysRepeatedChanged
                : null,
            children: const [
              Text('Mon'),
              Text('Tue'),
              Text('Wed'),
              Text('Thu'),
              Text('Fri'),
              Text('Sat'),
              Text('Sun'),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            DateInput(
              hintText: 'Date',
              value: state.dateTime,
              onChanged: !state.isRepeated
                  ? context.read<ActivityCubit>().dateTimeChanged
                  : null,
            ),
            const SizedBox(width: 8),
            TimeInput(
              hintText: 'Time',
              value: state.dateTime,
              onChanged: context.read<ActivityCubit>().dateTimeChanged,
            ),
          ],
        ),
        const SizedBox(height: 8),
        SelectionInput(
          hintText: 'Activity group',
          items: projects
              .map((projects) => DropdownMenuItem(
                  value: projects.id,
                  child: Text(projects.title!.isNotEmpty
                      ? projects.title!
                      : 'Untitled')))
              .toList(),
          onChanged: context.read<ActivityCubit>().projectIdChanged,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(selectedColor),
          onColorSelected: (color) => context
              .read<ActivityCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
