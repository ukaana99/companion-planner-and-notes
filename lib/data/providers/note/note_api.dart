import '../../models/note.dart';

abstract class NoteApi {
  const NoteApi();

  Future<Note> getNote(String id);

  Stream<Note> getNoteStream(String id);

  Future<List<Note>> getNotesByIds(List<String> ids);

  Stream<List<Note>> getNotesByGroupId(String id);

  Future<void> createNote(Note note);

  Future<void> updateNote(String id, Note note);

  Future<void> deleteNote(String id);
}
