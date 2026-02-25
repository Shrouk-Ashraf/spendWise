import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/config/routing/app_routes.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final prefs   = sl<SharedPreferences>();
    final name    = prefs.getString('user_name')  ?? 'User';
    final email   = prefs.getString('user_email') ?? '';
    final initial = name.isNotEmpty ? name[0].toUpperCase() : email[0].toUpperCase() ;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // ── Header ───────────────────────────────────────────────
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF4CAF50), Color(0xFF2E7D32)],
              ),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                initial,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
            ),
            accountName: Text(name,
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.w600)),
            accountEmail: Text(email,
                style: const TextStyle(fontSize: 13)),
          ),

          // ── Nav Items ─────────────────────────────────────────────
          _DrawerItem(
            icon: Icons.home_rounded,
            label: 'Home',
            onTap: () {
              Navigator.pop(context);
              context.goNamed(AppRoutes.dashboard);
            },
          ),
          _DrawerItem(
            icon: Icons.account_balance_wallet_rounded,
            label: 'Budgets',
            onTap: () {
              Navigator.pop(context);
              context.goNamed(AppRoutes.budgets);
            },
          ),
          _DrawerItem(
            icon: Icons.pie_chart_rounded,
            label: 'Reports',
            onTap: () {
              Navigator.pop(context);
              context.goNamed(AppRoutes.reports);
            },
          ),
          _DrawerItem(
            icon: Icons.savings_rounded,
            label: 'Savings',
            onTap: () {
              Navigator.pop(context);
              context.goNamed(AppRoutes.savings);
            },
          ),
          _DrawerItem(
            icon: Icons.person_rounded,
            label: 'Profile',
            onTap: () {
              Navigator.pop(context);
              context.goNamed(AppRoutes.profile);
            },
          ),

          const Divider(indent: 16, endIndent: 16),

          // ── Logout ────────────────────────────────────────────────
          _DrawerItem(
            icon: Icons.logout_rounded,
            label: 'Logout',
            iconColor: const Color(0xFFEF4444),
            labelColor: const Color(0xFFEF4444),
            onTap: () async {
              Navigator.pop(context);
              await sl<SharedPreferences>().setBool('is_logged_in', false);
              if (context.mounted) context.go('/login');
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

// ── Reusable item ─────────────────────────────────────────────────────────────
class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor,
    this.labelColor,
  });

  final IconData     icon;
  final String       label;
  final VoidCallback onTap;
  final Color?       iconColor;
  final Color?       labelColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? const Color(0xFF4B5563)),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: labelColor ?? const Color(0xFF111827),
        ),
      ),
      onTap: onTap,
      horizontalTitleGap: 8,
      contentPadding: const EdgeInsets.symmetric(
          horizontal: 20, vertical: 2),
    );
  }
}