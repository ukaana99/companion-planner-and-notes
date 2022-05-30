import 'package:cloud_firestore/cloud_firestore.dart';

import 'note_api.dart';
import '../../models/note.dart';

class NoteFirestoreApi extends NoteApi {
  final CollectionReference _notesRef =
      FirebaseFirestore.instance.collection('notes');

  @override
  Future<Note> getNote(String id) async {
    DocumentSnapshot snapshot = await _notesRef.doc(id).get();
    return Note.fromFire(snapshot);
  }

  @override
  Stream<Note> getNoteStream(String id) {
    Stream<DocumentSnapshot> stream =
        _notesRef.doc(id).snapshots(includeMetadataChanges: true);
    return stream.map((snapshot) => Note.fromFire(snapshot));
  }

  @override
  Future<List<Note>> getNotesByIds(List<String> ids) async {
    QuerySnapshot snapshots =
        await _notesRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs.map((snapshot) => Note.fromFire(snapshot)).toList();
  }

  @override
  Stream<List<Note>> getNotesByGroupId(String id) {
    Stream<QuerySnapshot> stream =
        _notesRef.where('groupId', isEqualTo: id).snapshots();
    return stream.map((snapshots) =>
        snapshots.docs.map((snapshot) => Note.fromFire(snapshot)).toList());
  }

  @override
  Future<void> createNote(Note note) async {
    return _notesRef.doc(note.id).set(note.toJson());
  }

  @override
  Future<void> updateNote(String id, Note note) async {
    return _notesRef.doc(id).update(note.toJson());
  }

  @override
  Future<void> deleteNote(String id) async {
    await _notesRef.doc(id).delete();
  }
}
