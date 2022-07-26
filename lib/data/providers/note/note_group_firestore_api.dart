import 'package:cloud_firestore/cloud_firestore.dart';

import 'note_group_api.dart';
import '../../models/note_group.dart';

class NoteGroupFirestoreApi extends NoteGroupApi {
  final CollectionReference _noteGroupsRef =
      FirebaseFirestore.instance.collection('noteGroups');

  @override
  Future<NoteGroup> getNoteGroup(String id) async {
    DocumentSnapshot snapshot = await _noteGroupsRef.doc(id).get();
    return NoteGroup.fromFire(snapshot);
  }

  @override
  Stream<NoteGroup> getNoteGroupStream(String id) {
    Stream<DocumentSnapshot> stream =
        _noteGroupsRef.doc(id).snapshots(includeMetadataChanges: true);
    return stream.map((snapshot) => NoteGroup.fromFire(snapshot));
  }

  @override
  Future<List<NoteGroup>> getNoteGroupsByIds(List<String> ids) async {
    QuerySnapshot snapshots =
        await _noteGroupsRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs
        .map((snapshot) => NoteGroup.fromFire(snapshot))
        .toList();
  }

  @override
  Stream<List<NoteGroup>> getNoteGroupsByUserId(String id) {
    Stream<QuerySnapshot> stream =
        _noteGroupsRef.where('userId', isEqualTo: id).snapshots();
    return stream.map((snapshots) => snapshots.docs
        .map((snapshot) => NoteGroup.fromFire(snapshot))
        .toList());
  }

  @override
  Stream<List<NoteGroup>> getNoteGroupsByProjectId(String id) {
    Stream<QuerySnapshot> stream =
        _noteGroupsRef.where('projectId', isEqualTo: id).snapshots();
    return stream.map((snapshots) => snapshots.docs
        .map((snapshot) => NoteGroup.fromFire(snapshot))
        .toList());
  }

  @override
  Future<void> createNoteGroup(NoteGroup noteGroup) async {
    return _noteGroupsRef.doc(noteGroup.id).set(noteGroup.toJson());
  }

  @override
  Future<void> updateNoteGroup(String id, NoteGroup noteGroup) async {
    return _noteGroupsRef.doc(id).update(noteGroup.toJson());
  }

  @override
  Future<void> deleteNoteGroup(String id) async {
    await _noteGroupsRef.doc(id).delete();
  }
}
