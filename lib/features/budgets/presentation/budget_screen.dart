import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:spendwise/features/budgets/presentation/widgets/budget_card.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../data/models/budget_model.dart';



final List<Budget> mockBudgets = [
  Budget(id: '1', category: 'Food & Dining', icon: 'utensils', budgeted: 500, spent: 320),
  Budget(id: '2', category: 'Shopping', icon: 'shopping', budgeted: 300, spent: 410),
  Budget(id: '3', category: 'Transport', icon: 'car', budgeted: 200, spent: 150),
  Budget(id: '4', category: 'Bills', icon: 'receipt', budgeted: 400, spent: 400),
  Budget(id: '5', category: 'Entertainment', icon: 'film', budgeted: 150, spent: 60),
];



class BudgetScreen extends StatelessWidget {
  const BudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final budgets = mockBudgets;
    final totalBudgeted = budgets.fold(0.0, (sum, b) => sum + b.budgeted);
    final totalSpent    = budgets.fold(0.0, (sum, b) => sum + b.spent);
    final remaining     = totalBudgeted - totalSpent;
    final overallPct    = (totalSpent / totalBudgeted).clamp(0.0, 1.0);

    return Scaffold(
      backgroundColor: AppColors.lightBackgroundColor,

      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,centerTitle: false,
        title: Text(
          'Budgets',
          style: AppTextStyles.text20SemiBoldDarkBlue,
        ),
        actions: [
          IconButton(
            onPressed: () => context.go('/add-budget'),
            icon: const Icon(Icons.add, color: AppColors.primary),
          ),
        ],
      ),
      body:SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primary, AppColors.mediumPrimaryColor],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.35),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                'January Budget',
                style: AppTextStyles.text14RegularSecondaryColor,
              ),
              const Gap(8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    '\$${totalSpent.toStringAsFixed(0)}',
                    style: AppTextStyles.text32BoldWhite,
                  ),
                  const Gap(8),
                  Text(
                    '/ \$${totalBudgeted.toStringAsFixed(0)}',
                    style: AppTextStyles.text16RegularSecondary ,
                  ),
                ],
              ),
              const Gap(16),

// Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: LinearProgressIndicator(
                  value: overallPct,
                  minHeight: 10,
                  backgroundColor: Colors.white.withValues(alpha: 0.25),
                  valueColor: const AlwaysStoppedAnimation(Colors.white),
                ),
              ),
              const Gap(10),

              Text(
                remaining > 0
                    ? '\$${remaining.toStringAsFixed(0)} left to spend'
                    : '\$${(totalSpent - totalBudgeted).toStringAsFixed(0)} over budget',
                style: AppTextStyles.text13RegularSecondary,
              ),
          ],
        ),
      ),
            const Gap(24),
             Text(
              'Categories',
              style: AppTextStyles.text18SemiBoldDarkBlue,
            ),
            const Gap(16),

// Budget cards
            ...budgets.map((budget) => BudgetCard(budget: budget)),

            const Gap(24),

// ── Add Budget Button ────────────────────────────────
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => context.go('/add-budget'),
                icon: const Icon(Icons.add, color: AppColors.primary),
                label:  Text(
                  'Add New Budget',
                  style: AppTextStyles.text15MediumPrimary,
                ),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: AppColors.primary, width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: Colors.white,
                ),
              ),
            ),

            const Gap(32),
            ],
        ),
      ),
    );
  }
}


