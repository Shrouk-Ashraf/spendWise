import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/nav_item_model.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  static const _navItems = [
    NavItem(icon: Icons.home_rounded, label: 'Home', path: '/dashboard'),
    NavItem(icon: Icons.account_balance_wallet_rounded, label: 'Budgets', path: '/budgets'),
    NavItem(icon: Icons.pie_chart_rounded, label: 'Reports', path: '/reports'),
    NavItem(icon: Icons.savings_rounded, label: 'Savings', path: '/savings'),
    NavItem(icon: Icons.person_rounded, label: 'Profile', path: '/profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey.shade200, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _navItems.map((item) {
              final isActive = location == item.path;

              return Expanded(
                child: GestureDetector(
                  onTap: () => context.go(item.path),
                  behavior: HitTestBehavior.translucent,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedScale(
                          scale: isActive ? 1.1 : 1.0,
                          duration: const Duration(milliseconds: 150),
                          child: Icon(
                            item.icon,
                            size: 24,
                            color: isActive
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.label,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight:
                            isActive ? FontWeight.w500 : FontWeight.normal,
                            color: isActive
                                ? const Color(0xFF4CAF50)
                                : Colors.grey.shade500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

