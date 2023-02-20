import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:handover/data/firebaseRepo.dart';
import 'package:handover/data/repo/home/home_repo_iml.dart';

import '../firebase_options.dart';
import 'navigator_service.dart';

final GetIt sl = GetIt.instance;

Future<void> setUpLocators() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  //services

  sl.registerLazySingleton<FirebaseRepo>(() => FirebaseRepo());

  sl.registerLazySingleton<NavigationService>(() => NavigationService());

  sl.registerLazySingleton<HomeRepoIml>(
      () => HomeRepoIml(firebaseRepo: sl<FirebaseRepo>()));
}
