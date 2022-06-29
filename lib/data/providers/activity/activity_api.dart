import '../../models/activity.dart';

abstract class ActivityApi {
  const ActivityApi();

  Future<Activity> getActivity(String id);

  Stream<Activity> getActivityStream(String id);

  Future<List<Activity>> getActivitiesByIds(List<String> ids);

  Stream<List<Activity>> getActivitiesByProjectId(String id);

  Stream<List<Activity>> getActivitiesByDateTime(String id, DateTime dateTime);

  Future<void> createActivity(Activity activity);

  Future<void> updateActivity(String id, Activity activity);

  Future<void> deleteActivity(String id);

  Future<void> deleteActivitiesByProjectId(String id);
}
