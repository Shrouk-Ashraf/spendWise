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
      builder: (BuildContext context, GoRouterState state) {
        return const OnboardingScreen();
      },
      redirect: (BuildContext context, GoRouterState state) {
        final box = Hive.box('app_settings');
        final hasCompletedOnboarding =
            box.get('completed', defaultValue: false) as bool;
        if (hasCompletedOnboarding) {
          return AppRoutes.login;
        } else {
          return null;
        }
      },
    ),
    GoRoute(
      path: '/login',
      name: AppRoutes.login,
      builder: (context, state) => LoginScreen(),
    ),
  ],
);
