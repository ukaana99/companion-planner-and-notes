part of '../note_groups_overview_page.dart';

class NoteGroupListTile extends StatelessWidget {
  const NoteGroupListTile(
    this.noteGroup, {
    Key? key,
  }) : super(key: key);

  final NoteGroup noteGroup;

  @override
  Widget build(BuildContext context) {
    final noteGroupColor = colorFromString(noteGroup.colorHex!);

    return Container(
      // height: 120,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundOverlay,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: ListTile(
        onTap: () => Navigator.pushNamed(context, AppRouter.noteGroup,
            arguments: {'noteGroup': noteGroup}),
        minVerticalPadding: 12.0,
        // tileColor: noteGroupColor.withOpacity(0.2),
        // tileColor: Theme.of(context).backgroundOverlay,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        leading: CircleAvatar(
          radius: 8.0,
          backgroundColor: noteGroupColor,
        ),
        title: Text(
          noteGroup.title!.isNotEmpty ? noteGroup.title! : 'Untitled',
          // style: Theme.of(context).textTheme.bodyText1,
        ),
        subtitle: Text(
          noteGroup.description!.isNotEmpty
              ? noteGroup.description!
              : 'No description available',
          // style: Theme.of(context).textTheme.bodyText2,
        ),
        isThreeLine: true,
      ),
    );
  }
}
