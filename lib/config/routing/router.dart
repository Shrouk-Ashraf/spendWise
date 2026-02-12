import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/features/authentication/presentation/login_screen.dart';
import 'package:spendwise/features/onboarding/presentation/onboarding_screen.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: AppRoutes.onboarding,
      builder: (BuildContext context, GoRouterState state) {
        debugPrint("Building OnboardingScreen");
        return const OnboardingScreen();
      },
      redirect: (BuildContext context, GoRouterState state)  {
        debugPrint("in redirect");
        final box = Hive.box('app_settings');
        debugPrint("box is $box");
        final hasCompleted = box.get('onboarding_completed', defaultValue: false) as bool;
        debugPrint("hasCompleted is $hasCompleted");
        return hasCompleted ? AppRoutes.login : AppRoutes.onboarding;
      },
    ),
    GoRoute(
      path: '/login',
      name: AppRoutes.login,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
