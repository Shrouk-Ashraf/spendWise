import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/features/savings/presentation/widgets/savings_overview_card.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/models/savings.dart';



IconData _getIcon(String icon) {
  switch (icon) {
    case 'shield': return Icons.shield_rounded;
    case 'plane':  return Icons.flight_rounded;
    case 'laptop': return Icons.laptop_rounded;
    case 'car':    return Icons.directions_car_rounded;
    default:       return Icons.savings_rounded;
  }
}

// ── Screen ───────────────────────────────────────────────────────────────────
class SavingsScreen extends StatelessWidget {
  const SavingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final totalTarget = savingsGoals.fold(0.0, (s, g) => s + g.target);
    final totalSaved  = savingsGoals.fold(0.0, (s, g) => s + g.saved);
    final overallPct  = (totalSaved / totalTarget).clamp(0.0, 1.0);
    final remaining   = totalTarget - totalSaved;

    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(
              'Savings Goals',
              style: AppTextStyles.text20SemiBoldDarkBlue,
            ),
            IconButton(
              onPressed: () => context.go('/add-savings-goal'),
              icon: const Icon(Icons.add, color: AppColors.primary),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child:
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── Overview Card ──────────────────────────────────
            SavingsOverviewCard(
              totalTarget: totalTarget,
              totalSaved: totalSaved,
              overallPct: overallPct,
              remaining: remaining,
            ),

            const Gap(32),

            // ── Goals List ─────────────────────────────────────
            const Text(
              'Your Goals',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 16),

            ...savingsGoals.map((goal) => _GoalCard(goal: goal)),

            const SizedBox(height: 24),

            // ── Add Goal Button ────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/add-savings-goal'),
                icon: const Icon(Icons.add, color: Color(0xFF2196F3)),
                label: const Text(
                  'Add New Goal',
                  style: TextStyle(
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(
                      color: Color(0xFF2196F3), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

// ── Goal Card ────────────────────────────────────────────────────────────────
class _GoalCard extends StatelessWidget {
  const _GoalCard({required this.goal});
  final SavingsGoal goal;

  @override
  Widget build(BuildContext context) {
    final isCompleted = goal.saved >= goal.target;
    final pct         = (goal.saved / goal.target).clamp(0.0, 1.0);
    final pctLabel    = (pct * 100).toStringAsFixed(0);
    final remaining   = goal.target - goal.saved;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: isCompleted
            ? Border.all(color: const Color(0xFF4CAF50), width: 2)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [

          // ── Top Row ──────────────────────────────────────────────
          Row(
            children: [
              // Icon circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? const Color(0xFFDCFCE7)
                      : const Color(0xFFDBEAFE),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : _getIcon(goal.icon),
                  size: 24,
                  color: isCompleted
                      ? const Color(0xFF4CAF50)
                      : const Color(0xFF2196F3),
                ),
              ),
              const SizedBox(width: 12),

              // Name + amount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '\$${goal.saved.toStringAsFixed(0)} of \$${goal.target.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 13, color: Color(0xFF6B7280)),
                    ),
                  ],
                ),
              ),

              // Completed badge
              if (isCompleted)
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDCFCE7),
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.check_circle_rounded,
                          size: 14, color: Color(0xFF4CAF50)),
                      SizedBox(width: 4),
                      Text(
                        'Completed',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4CAF50),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // ── Progress Bar ──────────────────────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: pct,
              minHeight: 8,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: AlwaysStoppedAnimation(
                isCompleted
                    ? const Color(0xFF4CAF50)
                    : const Color(0xFF2196F3),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // ── Bottom Labels ─────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$pctLabel% completed',
                style: const TextStyle(
                    fontSize: 12, color: Color(0xFF4B5563)),
              ),
              if (!isCompleted)
                Text(
                  '\$${remaining.toStringAsFixed(0)} to go',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF2196F3),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}