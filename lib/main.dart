import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';

import 'app/app.dart';
import 'app/app_bloc_observer.dart';

import 'data/providers/project/project_firestore_api.dart';

import 'data/repositories/auth_repo.dart';
import 'data/repositories/project_repo.dart';

Future<void> main() async {
  // FlutterServicesBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings =
      const Settings(cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  final projectApi = ProjectFirestoreApi();

  final authRepository = AuthRepository();
  final projectRepository = ProjectRepository(projectApi: projectApi);

  HydratedBlocOverrides.runZoned(
    () => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => App(
          connectivity: Connectivity(),
          authRepository: authRepository,
          projectRepository: projectRepository,
        ),
      ),
    ),
    blocObserver: AppBlocObserver(),
    storage: storage,
  );
}
