import 'package:cloud_firestore/cloud_firestore.dart';

import 'project_api.dart';
import '../../models/project.dart';

class ProjectFirestoreApi extends ProjectApi {
  final CollectionReference _projectsRef =
      FirebaseFirestore.instance.collection('projects');

  @override
  Future<Project> getProject(String id) async {
    DocumentSnapshot snapshot = await _projectsRef.doc(id).get();
    return Project.fromFire(snapshot);
  }

  @override
  Stream<Project> getProjectStream(String id) {
    Stream<DocumentSnapshot> stream =
        _projectsRef.doc(id).snapshots(includeMetadataChanges: true);
    return stream.map((snapshot) => Project.fromFire(snapshot));
  }

  @override
  Future<List<Project>> getProjectsByIds(List<String> ids) async {
    QuerySnapshot snapshots =
        await _projectsRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs
        .map((snapshot) => Project.fromFire(snapshot))
        .toList();
  }

  @override
  Stream<List<Project>> getProjectsByUserId(String id) {
    Stream<QuerySnapshot> stream =
        _projectsRef.where('userId', isEqualTo: id).snapshots();
    return stream.map((snapshots) =>
        snapshots.docs.map((snapshot) => Project.fromFire(snapshot)).toList());
  }

  @override
  Future<void> createProject(Project project) async {
    return _projectsRef.doc(project.id).set(project.toJson());
  }

  @override
  Future<void> updateProject(String id, Project project) async {
    return _projectsRef.doc(id).update(project.toJson());
  }

  @override
  Future<void> deleteProject(String id) async {
    await _projectsRef.doc(id).delete();
  }
}
