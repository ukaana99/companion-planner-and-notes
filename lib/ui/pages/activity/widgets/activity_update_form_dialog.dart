part of '../activity_page.dart';

class ActivityUpdateFormDialog extends StatelessWidget {
  const ActivityUpdateFormDialog({Key? key, required this.activity})
      : super(key: key);

  final Activity activity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ActivityCubit(
        activityRepository: context.read<ActivityRepository>(),
        activity: activity,
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
    final state = context.select((ActivityCubit cubit) => cubit.state);

    return FormDialog(
      title: "Edit activity",
      confirmLabel: "Update",
      onPressed: () => context.read<ActivityCubit>().updateForm(),
      children: [
        const SizedBox(height: 12),
        TextInput(
          initialValue: state.title,
          hintText: 'Title',
          onChanged: context.read<ActivityCubit>().titleChanged,
        ),
        const SizedBox(height: 8),
        TextInput(
          initialValue: state.description,
          hintText: 'Description',
          onChanged: context.read<ActivityCubit>().descriptionChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
          maxLength: 128,
        ),
        const SizedBox(height: 8),
        ColorListPicker(
          selectedColor: colorFromString(state.colorHex),
          onColorSelected: (color) => context
              .read<ActivityCubit>()
              .colorChanged(colorToString((color))),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
