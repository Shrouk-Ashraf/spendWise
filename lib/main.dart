import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/config/routing/router.dart';
import 'package:spendwise/core/theme/app_theme.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'core/theme/app_colors.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final prefs = await SharedPreferences.getInstance();

  await setupDI(prefs);
  await EasyLocalization.ensureInitialized();

  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.black
    ..indicatorColor = AppColors.primary
    ..backgroundColor = Colors.white;

  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: Locale('en', 'ar'),
        child: SpendWiseApp()
    ),
  );
}

class SpendWiseApp extends StatelessWidget {
  const SpendWiseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        builder: (_, child) {
          return BlocProvider(
            create: (context) => sl<AuthCubit>(),
            child: MaterialApp.router(
              // App Info
              title: 'spendwise',
              debugShowCheckedModeBanner: false,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              // Theme
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: ThemeMode.system,

              // Routing
              routerConfig: router,

              builder: EasyLoading.init(),
            ),
          );
        }
    );
  }
}
