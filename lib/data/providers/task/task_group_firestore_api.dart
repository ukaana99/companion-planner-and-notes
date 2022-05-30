import 'package:cloud_firestore/cloud_firestore.dart';

import 'task_group_api.dart';
import '../../models/task_group.dart';

class TaskGroupFirestoreApi extends TaskGroupApi {
  final CollectionReference _taskGroupsRef =
      FirebaseFirestore.instance.collection('taskGroups');

  @override
  Future<TaskGroup> getTaskGroup(String id) async {
    DocumentSnapshot snapshot = await _taskGroupsRef.doc(id).get();
    return TaskGroup.fromFire(snapshot);
  }

  @override
  Stream<TaskGroup> getTaskGroupStream(String id) {
    Stream<DocumentSnapshot> stream =
        _taskGroupsRef.doc(id).snapshots(includeMetadataChanges: true);
    return stream.map((snapshot) => TaskGroup.fromFire(snapshot));
  }

  @override
  Future<List<TaskGroup>> getTaskGroupsByIds(List<String> ids) async {
    QuerySnapshot snapshots =
        await _taskGroupsRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs
        .map((snapshot) => TaskGroup.fromFire(snapshot))
        .toList();
  }

  @override
  Stream<List<TaskGroup>> getTaskGroupsByUserId(String id) {
    Stream<QuerySnapshot> stream =
        _taskGroupsRef.where('userId', isEqualTo: id).snapshots();
    return stream.map((snapshots) => snapshots.docs
        .map((snapshot) => TaskGroup.fromFire(snapshot))
        .toList());
  }

  // @override
  // Stream<List<TaskGroup>> getPendingTaskGroups(String id) {
  //   Stream<QuerySnapshot> stream = _taskGroupsRef
  //       .where('userId', isEqualTo: id)
  //       .where('completion', isNotEqualTo: 100)
  //       .snapshots();
  //   return stream.map((snapshots) => snapshots.docs
  //       .map((snapshot) => TaskGroup.fromFire(snapshot))
  //       .toList());
  // }

  // @override
  // Stream<List<TaskGroup>> getDoneTaskGroups(String id) {
  //   Stream<QuerySnapshot> stream = _taskGroupsRef
  //       .where('userId', isEqualTo: id)
  //       .where('completion', isEqualTo: 100)
  //       .snapshots();
  //   return stream.map((snapshots) => snapshots.docs
  //       .map((snapshot) => TaskGroup.fromFire(snapshot))
  //       .toList());
  // }

  @override
  Stream<List<TaskGroup>> getTaskGroupsByProjectId(String id) {
    Stream<QuerySnapshot> stream =
        _taskGroupsRef.where('taskgroupId', isEqualTo: id).snapshots();
    return stream.map((snapshots) => snapshots.docs
        .map((snapshot) => TaskGroup.fromFire(snapshot))
        .toList());
  }

  @override
  Future<void> createTaskGroup(TaskGroup taskGroup) async {
    return _taskGroupsRef.doc(taskGroup.id).set(taskGroup.toJson());
  }

  @override
  Future<void> updateTaskGroup(String id, TaskGroup taskGroup) async {
    return _taskGroupsRef.doc(id).update(taskGroup.toJson());
  }

  @override
  Future<void> deleteTaskGroup(String id) async {
    await _taskGroupsRef.doc(id).delete();
  }
}
