import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/features/authentication/presentation/login_screen.dart';
import 'package:spendwise/features/authentication/presentation/signup_screen.dart';
import 'package:spendwise/features/dashboard/presentation/dashboard.dart';
import 'package:spendwise/features/onboarding/presentation/onboarding_screen.dart';
import 'package:spendwise/features/transactions/presentation/get_transaction/transactions_screen.dart';
import 'package:spendwise/features/transactions/presentation/transaction_details/presentation/transaction_details_screen.dart';
import '../../features/budgets/presentation/budget_screen.dart';
import '../../features/layout/presentation/scaffold_with_bottom_nav.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/savings/presentation/savings_screen.dart';
import '../../features/transactions/presentation/add_transaction/add_transaction_screen.dart';
import '../di/di.dart';

final GoRouter router = GoRouter(
  initialLocation: '/onboarding',
  redirect: (context,state){
    final prefs = sl<SharedPreferences>();
    final hasCompleted = prefs.getBool('onboarding_completed') ?? false;
    final isLoggedIn   = prefs.getBool('is_logged_in')         ?? false;
    final location = state.matchedLocation;
    if (!hasCompleted) {
      return location == '/onboarding' ? null : '/onboarding';
    }
    const authRoutes = {'/login', '/register'};
    if (!isLoggedIn) {
      return authRoutes.contains(location) ? null : '/login';
    }

    if (isLoggedIn && authRoutes.contains(location)) {
      return '/dashboard';
    }

    return null;
  },
  routes: <RouteBase>[
    // ── Onboarding ───────────────────────────────────────────────────────────
    GoRoute(
      path: '/onboarding',
      name: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),

    // ── Authentication Flow ──────────────────────────────────────────────────
    GoRoute(
      path: '/login',
      name: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: AppRoutes.register,
      builder: (context, state) => const SignupScreen(),
    ),
    // ── Main App Screens (with Bottom Nav via ShellRoute) ────────────────────
    ShellRoute(
      builder: (context, state, child) => ScaffoldWithBottomNav(child: child),
      routes: [
        GoRoute(
          path: '/dashboard',
          name: AppRoutes.dashboard,
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/budgets',
          name: AppRoutes.budgets,
          builder: (context, state) => const BudgetScreen(),
        ),
        GoRoute(
          path: '/reports',
          name: AppRoutes.reports,
          builder: (context, state) => const ReportsScreen(),
        ),
        GoRoute(
          path: '/savings',
          name: AppRoutes.savings,
          builder: (context, state) => const SavingsScreen(),
        ),
        GoRoute(
          path: '/profile',
          name: AppRoutes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),

    // // ── Secondary Screens (no Bottom Nav) ────────────────────────────────────
    GoRoute(
      path: '/add-transaction',
      name: AppRoutes.addTransaction,
      builder: (context, state) => const AddTransactionScreen(),
    ),
    // GoRoute(
    //   path: '/add-budget',
    //   name: AppRoutes.addBudget,
    //   builder: (context, state) => const AddBudgetScreen(),
    // ),
    // GoRoute(
    //   path: '/add-savings-goal',
    //   name: AppRoutes.addSavingsGoal,
    //   builder: (context, state) => const AddSavingsGoalScreen(),
    // ),
    // GoRoute(
    //   path: '/notifications',
    //   name: AppRoutes.notifications,
    //   builder: (context, state) => const NotificationsScreen(),
    // ),
    //
    // // ── Transaction Screens ───────────────────────────────────────────────────
    GoRoute(
      path: '/transactions',
      name: AppRoutes.transactions,
      builder: (context, state) => const AllTransactionsScreen(),
    ),
    GoRoute(
      path: '/transaction-detail',
      name: AppRoutes.transactionDetail,
      builder: (context, state) {
        final id = state.extra as String;
        return TransactionDetailScreen(id: id);
      },
    ),

  ],
);
