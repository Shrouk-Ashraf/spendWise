import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/features/profile/presentation/widgets/user_info_card.dart';

import '../../../core/theme/app_text_styles.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notifications = true;
  bool _darkMode = false;

  void _handleLogout() {
    // TODO: clear Hive session then navigate
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,

        title:Text(
          'Profile & Settings',
          style: AppTextStyles.text20SemiBoldDarkBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // ── User Info Card ─────────────────────────────────
              UserInfoCard(),

              const Gap(32),

              // ── App Preferences ────────────────────────────────
              _SectionLabel(label: 'App Preferences'),
              const Gap(12),
              _SettingsGroup(
                children: [
                  _ToggleRow(
                    icon: Icons.notifications_rounded,
                    label: 'Notifications',
                    value: _notifications,
                    onChanged: (v) => setState(() => _notifications = v),
                    hasDivider: true,
                  ),
                  _ToggleRow(
                    icon: Icons.dark_mode_rounded,
                    label: 'Dark Mode',
                    value: _darkMode,
                    onChanged: (v) => setState(() => _darkMode = v),
                  ),
                ],
              ),

              const Gap( 24),

              // ── Account Settings ───────────────────────────────
              _SectionLabel(label: 'Account Settings'),
              const Gap( 12),
              _SettingsGroup(
                children: [
                  _NavRow(
                    icon: Icons.person_rounded,
                    label: 'Edit Profile',
                    onTap: () {},
                    hasDivider: true,
                  ),
                  _NavRow(
                    icon: Icons.lock_rounded,
                    label: 'Change Password',
                    onTap: () {},
                  ),
                ],
              ),

              const Gap( 24),

              // ── Support ────────────────────────────────────────
              _SectionLabel(label: 'Support'),
              const Gap( 12),
              _SettingsGroup(
                children: [
                  _NavRow(
                    icon: Icons.help_outline_rounded,
                    label: 'Help & FAQ',
                    onTap: () {},
                  ),
                ],
              ),

              const Gap( 24),

              // ── Logout Button ──────────────────────────────────
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: _handleLogout,
                  icon: const Icon(Icons.logout_rounded,
                      color: AppColors.redColor, size: 20),
                  label: const Text(
                    'Log Out',
                    style: AppTextStyles.text13MediumRedColor,
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const Gap( 20),

              // ── Version ────────────────────────────────────────
              const Center(
                child: Text(
                  'Spend Wise v1.0.0',
                  style: AppTextStyles.text16NormalGray400,
                ),
              ),

              const Gap( 32),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Reusable Widgets ─────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.text12SemiBoldGray500
      ),
    );
  }
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }
}

// Row with a toggle switch
class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hasDivider = false,
  });

  final IconData icon;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 20, color:  AppColors.lightGray),
              const Gap( 12),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.text15RegularDarkBlue,
                ),
              ),
              Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.primary,
              ),
            ],
          ),
        ),
        if (hasDivider)
          const Divider(height: 1, indent: 48, color: AppColors.semiWhite),
      ],
    );
  }
}

// Row with a chevron (navigation)
class _NavRow extends StatelessWidget {
  const _NavRow({
    required this.icon,
    required this.label,
    required this.onTap,
    this.hasDivider = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 16),
            child: Row(
              children: [
                Icon(icon, size: 20, color: AppColors.lightGray),
                const Gap( 12),
                Expanded(
                  child: Text(
                    label,
                    style: AppTextStyles.text15RegularDarkBlue,
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    size: 20, color:AppColors.gray400),
              ],
            ),
          ),
        ),
        if (hasDivider)
          const Divider(height: 1, indent: 48, color: AppColors.semiWhite),
      ],
    );
  }
}