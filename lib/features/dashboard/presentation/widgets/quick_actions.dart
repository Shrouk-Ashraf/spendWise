import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/features/dashboard/presentation/widgets/quich_action_card.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';


class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Text(
            'Quick Actions',
            style: AppTextStyles.text18SemiBoldBlack,
          ),
          const Gap(16),
          GridView.count(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: [
              QuickActionCard(
                icon: Icons.trending_down,
                iconColor: Colors.red,
                backgroundColor: Colors.green[100]!,
                label: 'Add Expense',
                onTap: () => context.go('/add-transaction'),
              ),
              QuickActionCard(
                icon: Icons.trending_up,
                iconColor: AppColors.primary,
                backgroundColor: Colors.green[100]!,
                label: 'Add Income',
                onTap: () => context.go('/add-transaction?type=income'),
              ),
              QuickActionCard(
                icon: Icons.receipt_outlined,
                iconColor: AppColors.lightBlueColor,
                backgroundColor: Colors.blue[100]!,
                label: 'Budgets',
                onTap: () => context.go('/budgets'),
              ),
              QuickActionCard(
                icon: Icons.savings_outlined,
                iconColor: Colors.purple,
                backgroundColor: Colors.purple[100]!,
                label: 'Savings',
                onTap: () => context.go('/savings'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
