import '../models/note_group.dart';
import '../providers/note/note_group_api.dart';

class NoteGroupRepository {
  final NoteGroupApi _noteGroupApi;

  const NoteGroupRepository({
    required NoteGroupApi noteGroupApi,
  }) : _noteGroupApi = noteGroupApi;

  Future<NoteGroup> getNoteGroup(String id) => _noteGroupApi.getNoteGroup(id);

  Stream<NoteGroup> getNoteGroupStream(String id) =>
      _noteGroupApi.getNoteGroupStream(id);

  Future<List<NoteGroup>> getNoteGroupsByIds(List<String> ids) =>
      _noteGroupApi.getNoteGroupsByIds(ids);

  Stream<List<NoteGroup>> getNoteGroupsByUserId(String userId) =>
      _noteGroupApi.getNoteGroupsByUserId(userId);

  Future<void> createNoteGroup(NoteGroup notegroup) =>
      _noteGroupApi.createNoteGroup(notegroup);

  Future<void> updateNoteGroup(String id, NoteGroup notegroup) =>
      _noteGroupApi.updateNoteGroup(id, notegroup);

  Future<void> deleteNoteGroup(String id) => _noteGroupApi.deleteNoteGroup(id);
}
