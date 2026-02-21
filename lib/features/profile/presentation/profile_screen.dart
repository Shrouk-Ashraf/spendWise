import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      backgroundColor: const Color(0xFFF9FAFB),
      body: CustomScrollView(
        slivers: [

          // ── Sticky Header ──────────────────────────────────────────
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 1,
            automaticallyImplyLeading: false,
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => context.go('/dashboard'),
                    icon: const Icon(Icons.arrow_back,
                        color: Color(0xFF374151)),
                  ),
                  const Text(
                    'Profile & Settings',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF111827),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // ── User Info Card ─────────────────────────────────
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'A',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),

                        // Name + email
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alex Johnson',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF111827),
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'alex.johnson@email.com',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B7280),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Edit button
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Edit',
                            style: TextStyle(
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // ── App Preferences ────────────────────────────────
                  _SectionLabel(label: 'App Preferences'),
                  const SizedBox(height: 12),
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

                  const SizedBox(height: 24),

                  // ── Account Settings ───────────────────────────────
                  _SectionLabel(label: 'Account Settings'),
                  const SizedBox(height: 12),
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

                  const SizedBox(height: 24),

                  // ── Support ────────────────────────────────────────
                  _SectionLabel(label: 'Support'),
                  const SizedBox(height: 12),
                  _SettingsGroup(
                    children: [
                      _NavRow(
                        icon: Icons.help_outline_rounded,
                        label: 'Help & FAQ',
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // ── Logout Button ──────────────────────────────────
                  SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                      onPressed: _handleLogout,
                      icon: const Icon(Icons.logout_rounded,
                          color: Color(0xFFDC2626), size: 20),
                      label: const Text(
                        'Log Out',
                        style: TextStyle(
                          color: Color(0xFFDC2626),
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                        ),
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

                  const SizedBox(height: 20),

                  // ── Version ────────────────────────────────────────
                  const Center(
                    child: Text(
                      'Spend Wise v1.0.0',
                      style: TextStyle(
                          fontSize: 13, color: Color(0xFF9CA3AF)),
                    ),
                  ),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
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
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Color(0xFF6B7280),
          letterSpacing: 0.8,
        ),
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
            color: Colors.black.withOpacity(0.06),
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
              Icon(icon, size: 20, color: const Color(0xFF4B5563)),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                      fontSize: 15, color: Color(0xFF111827)),
                ),
              ),
              Switch.adaptive(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xFF4CAF50),
              ),
            ],
          ),
        ),
        if (hasDivider)
          const Divider(height: 1, indent: 48, color: Color(0xFFF3F4F6)),
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
                Icon(icon, size: 20, color: const Color(0xFF4B5563)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                        fontSize: 15, color: Color(0xFF111827)),
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    size: 20, color: Color(0xFF9CA3AF)),
              ],
            ),
          ),
        ),
        if (hasDivider)
          const Divider(height: 1, indent: 48, color: Color(0xFFF3F4F6)),
      ],
    );
  }
}