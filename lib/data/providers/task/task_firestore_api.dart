import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_api.dart';
import '../../models/task.dart';

class TaskFirestoreApi extends TaskApi {
  final CollectionReference _tasksRef =
      FirebaseFirestore.instance.collection('tasks');

  @override
  Future<Task> getTask(String id) async {
    DocumentSnapshot snapshot = await _tasksRef.doc(id).get();
    return Task.fromFire(snapshot);
  }

  @override
  Stream<Task> getTaskStream(String id) {
    Stream<DocumentSnapshot> stream =
        _tasksRef.doc(id).snapshots(includeMetadataChanges: true);
    return stream.map((snapshot) => Task.fromFire(snapshot));
  }

  @override
  Future<List<Task>> getTasksByIds(List<String> ids) async {
    QuerySnapshot snapshots =
        await _tasksRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs.map((snapshot) => Task.fromFire(snapshot)).toList();
  }

  @override
  Stream<List<Task>> getTasksByGroupId(String id) {
    Stream<QuerySnapshot> stream =
        _tasksRef.where('groupId', isEqualTo: id).snapshots();
    return stream.map((snapshots) =>
        snapshots.docs.map((snapshot) => Task.fromFire(snapshot)).toList());
  }

  @override
  Future<void> createTask(Task task) async {
    return _tasksRef.doc(task.id).set(task.toJson());
  }

  @override
  Future<void> updateTask(String id, Task task) async {
    return _tasksRef.doc(id).update(task.toJson());
  }

  @override
  Future<void> deleteTask(String id) async {
    await _tasksRef.doc(id).delete();
  }
}
