import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:handover/routes/generated_routes.dart';
import 'package:handover/service_locater/service_locater.dart';
import 'package:handover/shared/app_constants/app_colors.dart';
import 'package:handover/shared/app_constants/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:handover/shared/app_constants/custom_theme.dart';
import 'package:handover/ui/home/home_screen.dart';

import 'bloc/main_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MainBlocObserver();
  await setUpLocators();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
            theme: CustomTheme.lightTheme,
            debugShowCheckedModeBanner: false,
            title: AppConstants.appName,
            onGenerateRoute: GenerateRoutes.generateRoute,
            locale: const Locale('en', 'US'),
            // initialRoute: SplashScreen.splash,
            home: child!);
      },
      child: const HomeScreen(),
    );
  }
}
