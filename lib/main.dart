import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_preview/device_preview.dart';

import 'app/app.dart';
import 'logic/utility/app_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );

  HydratedBlocOverrides.runZoned(
    () => runApp(
      DevicePreview(
        enabled: false,
        builder: (context) => App(
          connectivity: Connectivity(),
        ),
      ),
    ),
    blocObserver: SimpleBlocObserver(),
    storage: storage,
  );
}
