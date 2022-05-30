import '../../models/note_group.dart';

abstract class NoteGroupApi {
  const NoteGroupApi();

  Future<NoteGroup> getNoteGroup(String id);

  Stream<NoteGroup> getNoteGroupStream(String id);

  Future<List<NoteGroup>> getNoteGroupsByIds(List<String> ids);

  Stream<List<NoteGroup>> getNoteGroupsByUserId(String id);
  
  Stream<List<NoteGroup>> getNoteGroupsByProjectId(String id);

  Future<void> createNoteGroup(NoteGroup noteGroup);

  Future<void> updateNoteGroup(String id, NoteGroup noteGroup);

  Future<void> deleteNoteGroup(String id);
}
