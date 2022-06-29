import '../models/activity.dart';
import '../providers/activity/activity_api.dart';

class ActivityRepository {
  final ActivityApi _activityApi;

  const ActivityRepository({
    required ActivityApi activityApi,
  }) : _activityApi = activityApi;

  Future<Activity> getActivity(String id) => _activityApi.getActivity(id);

  Stream<Activity> getActivityStream(String id) =>
      _activityApi.getActivityStream(id);

  Future<List<Activity>> getActivitiesByIds(List<String> ids) =>
      _activityApi.getActivitiesByIds(ids);

  Stream<List<Activity>> getActivitiesByProjectId(String projectId) =>
      _activityApi.getActivitiesByProjectId(projectId);

  Stream<List<Activity>> getActivitiesByDateTime(
          String userId, DateTime dateTime) =>
      _activityApi.getActivitiesByDateTime(userId, dateTime);

  Future<void> createActivity(Activity activity) =>
      _activityApi.createActivity(activity);

  Future<void> updateActivity(String id, Activity activity) =>
      _activityApi.updateActivity(id, activity);

  Future<void> deleteActivity(String id) => _activityApi.deleteActivity(id);

  Future<void> deleteActivitiesByProjectId(String id) =>
      _activityApi.deleteActivitiesByProjectId(id);
}
