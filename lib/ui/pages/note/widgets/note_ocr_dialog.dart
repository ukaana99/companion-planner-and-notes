part of '../note_page.dart';

class NoteOCRModal extends StatelessWidget {
  const NoteOCRModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    XFile? image;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const ListTile(
          title: Text('Select source'),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Take photo'),
          onTap: () async {
            image = await _picker.pickImage(source: ImageSource.camera);
            context.read<NoteCubit>().imageChanged(image);
            if (image != null) {
              await context.read<NoteCubit>().processImage();
              await showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<NoteCubit>(),
                  child: const NoteOCRDialog(),
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.photo),
          title: const Text('Choose existing photo'),
          onTap: () async {
            image = await _picker.pickImage(source: ImageSource.gallery);
            context.read<NoteCubit>().imageChanged(image);
            if (image != null) {
              await context.read<NoteCubit>().processImage();
              await showDialog(
                context: context,
                builder: (_) => BlocProvider.value(
                  value: context.read<NoteCubit>(),
                  child: const NoteOCRDialog(),
                ),
              );
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}

class NoteOCRDialog extends StatelessWidget {
  const NoteOCRDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.select((NoteCubit bloc) => bloc.state);

    return FormDialog(
      title: "Note OCR",
      confirmLabel: "Add",
      onPressed: () => context.read<NoteCubit>().addScannedText(),
      children: [
        Semantics(
          label: 'image_picker_example_picked_image',
          child: kIsWeb
              ? Image.network(state.image!.path)
              : Image.file(File(state.image!.path)),
        ),
        const SizedBox(height: 16),
        TextInput(
          initialValue: state.scannedText,
          hintText: 'No output',
          onChanged: context.read<NoteCubit>().scannedTextChanged,
          keyboardType: TextInputType.multiline,
          minLines: 3,
          maxLines: null,
        ),
      ],
    );
  }
}
