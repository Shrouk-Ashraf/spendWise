import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendwise/config/di/di.dart';
import 'package:spendwise/config/routing/app_routes.dart';
import 'package:spendwise/core/theme/app_colors.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';
import 'package:spendwise/core/theme/theme_cubit.dart';
import 'package:spendwise/core/theme/theme_state.dart';
import 'package:spendwise/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:spendwise/features/profile/presentation/cubit/profile_state.dart';
import 'package:spendwise/features/profile/presentation/widgets/user_info_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<ProfileCubit>()..loadProfile(),
        ),
      ],
      child: BlocListener<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state.status == ProfileStatus.loggedOut) {
            context.goNamed(AppRoutes.login);
          }
          if (state.status == ProfileStatus.passwordResetSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'Password reset email sent! Check your inbox.'),
                backgroundColor: AppColors.primary,
              ),
            );
          }
          if (state.status == ProfileStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    state.errorMessage ?? 'Something went wrong'),
                backgroundColor: AppColors.redColor,
              ),
            );
          }
        },

       child : BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.lightBackgroundColor,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                automaticallyImplyLeading: false,
                scrolledUnderElevation: 0,
                title: Text(
                  'Profile & Settings',
                  style: AppTextStyles.text20SemiBoldDarkBlue,
                ),
              ),
              body: state.status == ProfileStatus.loading
                  ? const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primary))
                  : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // ── User Info Card ──────────────────
                      UserInfoCard(
                        name:          state.name,
                        email:         state.email,
                        avatarInitial: state.avatarInitial,
                      ),

                      const Gap(32),

                      // ── App Preferences ─────────────────
                      const _SectionLabel(
                          label: 'App Preferences'),
                      const Gap(12),
                      _SettingsGroup(
                        children: [

                          // ── Notifications ───────────────
                        _ToggleRow(
                        icon: Icons.notifications_rounded,
                        label: 'Notifications',
                        hasDivider: true,
                        value: state.notificationsEnabled,
                        onChanged: (v) =>
                            ProfileCubit.get(context)
                                .toggleNotifications(v),
                      ),

                          // ── Dark Mode ───────────────────
                          BlocBuilder<ThemeCubit, ThemeState>(
                            builder: (context, themeState) {
                              return _ToggleRow(
                                icon: Icons.dark_mode_rounded,
                                label: 'Dark Mode',
                                value: themeState.themeMode ==
                                    ThemeMode.dark,
                                onChanged: (_) => context
                                    .read<ThemeCubit>()
                                    .toggle(),
                              );
                            },
                          ),
                        ],
                      ),

                      const Gap(24),



                      // ── Logout ────────────────────────────
                      SizedBox(
                        width: double.infinity,
                        child: TextButton.icon(
                          onPressed: () =>
                              ProfileCubit.get(context).logout(),
                          icon: const Icon(Icons.logout_rounded,
                              color: AppColors.redColor, size: 20),
                          label: const Text(
                            'Log Out',
                            style:
                            AppTextStyles.text13MediumRedColor,
                          ),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16),
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const Gap(20),

                      // ── Version ───────────────────────────
                      const Center(
                        child: Text(
                          'Spend Wise v1.0.0',
                          style: AppTextStyles.text16NormalGray400,
                        ),
                      ),

                      const Gap(32),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ── Reusable Widgets ──────────────────────────────────────────────────────────

class _SectionLabel extends StatelessWidget {
  const _SectionLabel({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.text12SemiBoldGray500,
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

class _ToggleRow extends StatelessWidget {
  const _ToggleRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onChanged,
    this.hasDivider = false,
  });

  final IconData           icon;
  final String             label;
  final bool               value;
  final ValueChanged<bool> onChanged;
  final bool               hasDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16, vertical: 4),
          child: Row(
            children: [
              Icon(icon, size: 20, color: AppColors.lightGray),
              const Gap(12),
              Expanded(
                child: Text(label,
                    style: AppTextStyles.text15RegularDarkBlue),
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
          const Divider(
              height: 1, indent: 48, color: AppColors.semiWhite),
      ],
    );
  }
}
