import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';

import 'data/providers/user/user_firestore_api.dart';
import 'data/providers/activity/activity_firestore_api.dart';
import 'data/providers/project/project_firestore_api.dart';
import 'data/providers/note/note_firestore_api.dart';
import 'data/providers/note/note_group_firestore_api.dart';
import 'data/providers/task/task_firestore_api.dart';
import 'data/providers/task/task_group_firestore_api.dart';

import 'data/repositories/auth_repo.dart';
import 'data/repositories/user_repo.dart';
import 'data/repositories/activity_repo.dart';
import 'data/repositories/project_repo.dart';
import 'data/repositories/note_repo.dart';
import 'data/repositories/note_group_repo.dart';
import 'data/repositories/task_repo.dart';
import 'data/repositories/task_group_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  final userApi = UserFirestoreApi();
  final activityApi = ActivityFirestoreApi();
  final projectApi = ProjectFirestoreApi();
  final noteApi = NoteFirestoreApi();
  final noteGroupApi = NoteGroupFirestoreApi();
  final taskApi = TaskFirestoreApi();
  final taskGroupApi = TaskGroupFirestoreApi();

  final authRepository = AuthRepository(userApi: userApi);
  final userRepository = UserRepository(userApi: userApi);
  final activityRepository = ActivityRepository(activityApi: activityApi);
  final projectRepository = ProjectRepository(projectApi: projectApi);
  final noteRepository = NoteRepository(noteApi: noteApi);
  final noteGroupRepository = NoteGroupRepository(noteGroupApi: noteGroupApi);
  final taskRepository = TaskRepository(taskApi: taskApi);
  final taskGroupRepository = TaskGroupRepository(taskGroupApi: taskGroupApi);

  HydratedBlocOverrides.runZoned(
    () => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => App(
          connectivity: Connectivity(),
          authRepository: authRepository,
          userRepository: userRepository,
          activityRepository: activityRepository,
          projectRepository: projectRepository,
          noteRepository: noteRepository,
          noteGroupRepository: noteGroupRepository,
          taskRepository: taskRepository,
          taskGroupRepository: taskGroupRepository,
        ),
      ),
    ),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );
}
