/// Route path constants for the app.
///
/// Use these constants instead of hardcoded strings for type safety.
/// Access via: `AppRoutes.home`
abstract class AppRoutes {
  // ─────────────────────────────────────────────────────────────────────────
  // Auth Routes
  // ─────────────────────────────────────────────────────────────────────────
  static const String onboarding = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // ─────────────────────────────────────────────────────────────────────────
  // Main Routes
  // ─────────────────────────────────────────────────────────────────────────
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String expenses = '/expenses';
  static const String addExpense = '/expenses/add';
  static const String editExpense = '/expenses/edit/:id';
  static const String expenseDetails = '/expenses/:id';

  // ─────────────────────────────────────────────────────────────────────────
  // Statistics / Reports
  // ─────────────────────────────────────────────────────────────────────────
  static const String statistics = '/statistics';
  static const String reports = '/reports';

  // ─────────────────────────────────────────────────────────────────────────
  // Settings / Profile
  // ─────────────────────────────────────────────────────────────────────────
  static const String settings = '/settings';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';

  // ─────────────────────────────────────────────────────────────────────────
  // Helper Methods
  // ─────────────────────────────────────────────────────────────────────────

  /// Generates the edit expense route with the given ID
  static String editExpenseWithId(String id) => '/expenses/edit/$id';

  /// Generates the expense details route with the given ID
  static String expenseDetailsWithId(String id) => '/expenses/$id';
}
