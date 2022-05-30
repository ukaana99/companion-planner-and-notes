import '../models/note.dart';
import '../providers/note/note_api.dart';

class NoteRepository {
  final NoteApi _noteApi;

  const NoteRepository({
    required NoteApi noteApi,
  }) : _noteApi = noteApi;

  Future<Note> getNote(String id) => _noteApi.getNote(id);

  Stream<Note> getNoteStream(String id) =>
      _noteApi.getNoteStream(id);
      
  Future<List<Note>> getNotesByIds(List<String> ids) =>
      _noteApi.getNotesByIds(ids);

  Stream<List<Note>> getNotesByGroupId(String userId) =>
      _noteApi.getNotesByGroupId(userId);

  Future<void> createNote(Note note) => _noteApi.createNote(note);

  Future<void> updateNote(String id, Note note) =>
      _noteApi.updateNote(id, note);

  Future<void> deleteNote(String id) => _noteApi.deleteNote(id);
}
