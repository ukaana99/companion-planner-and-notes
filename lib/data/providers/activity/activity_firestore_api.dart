import 'package:cloud_firestore/cloud_firestore.dart';

import 'activity_api.dart';
import '../../models/activity.dart';

class ActivityFirestoreApi extends ActivityApi {
  final CollectionReference _activitiesRef =
      FirebaseFirestore.instance.collection('activities');

  @override
  Future<Activity> getActivity(String id) async {
    DocumentSnapshot snapshot = await _activitiesRef.doc(id).get();
    return Activity.fromFire(snapshot);
  }

  @override
  Stream<Activity> getActivityStream(String id) {
    Stream<DocumentSnapshot> stream =
        _activitiesRef.doc(id).snapshots(includeMetadataChanges: true);
    return stream.map((snapshot) => Activity.fromFire(snapshot));
  }

  @override
  Future<List<Activity>> getActivitiesByIds(List<String> ids) async {
    QuerySnapshot snapshots =
        await _activitiesRef.where(FieldPath.documentId, whereIn: ids).get();
    return snapshots.docs
        .map((snapshot) => Activity.fromFire(snapshot))
        .toList();
  }

  @override
  Stream<List<Activity>> getActivitiesByProjectId(String id) {
    Stream<QuerySnapshot> stream =
        _activitiesRef.where('projectId', isEqualTo: id).snapshots();
    return stream.map((snapshots) =>
        snapshots.docs.map((snapshot) => Activity.fromFire(snapshot)).toList());
  }

  @override
  Stream<List<Activity>> getActivitiesByDateTime(String id, DateTime dateTime) {
    Stream<QuerySnapshot> stream = _activitiesRef
        .where('userId', isEqualTo: id)
        .where('dateTime', isGreaterThanOrEqualTo: dateTime)
        .where('dateTime',
            isLessThan:
                DateTime(dateTime.year, dateTime.month, dateTime.day + 1))
        .snapshots();
    return stream.map((snapshots) =>
        snapshots.docs.map((snapshot) => Activity.fromFire(snapshot)).toList());
  }

  @override
  Future<void> createActivity(Activity activity) async {
    return _activitiesRef.doc(activity.id).set(activity.toJson());
  }

  @override
  Future<void> updateActivity(String id, Activity activity) async {
    return _activitiesRef.doc(id).update(activity.toJson());
  }

  @override
  Future<void> deleteActivity(String id) async {
    await _activitiesRef.doc(id).delete();
  }

  @override
  Future<void> deleteActivitiesByProjectId(String id) async {
    QuerySnapshot snapshots =
        await _activitiesRef.where('projectId', isEqualTo: id).get();
    for (var doc in snapshots.docs) {
      doc.reference.delete();
    }
  }
}
