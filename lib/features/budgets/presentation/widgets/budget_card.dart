import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';
import '../../data/models/budget_model.dart';

class BudgetCard extends StatelessWidget {
  const BudgetCard({required this.budget});

  final Budget budget;

  @override
  Widget build(BuildContext context) {
    final isOverBudget = budget.spent > budget.budgeted;
    final percentage   = (budget.spent / budget.budgeted).clamp(0.0, 1.0);
    final pctLabel     = ((budget.spent / budget.budgeted) * 100).toStringAsFixed(0);

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
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
      child: Column(
        children: [
          Row(
            children: [
              // Icon circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isOverBudget
                      ?  AppColors.lightRed
                      : AppColors.semiWhite,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _getIcon(budget.icon),
                  size: 22,
                  color: isOverBudget
                      ? AppColors.redColor
                      : AppColors.lightGray,
                ),
              ),
              const Gap(12),

              // Category + amount
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      budget.category,
                      style: AppTextStyles.text15SemiBoldDarkBlue,
                    ),
                    const Gap(2),
                    Text(
                      '\$${budget.spent.toStringAsFixed(0)} of \$${budget.budgeted.toStringAsFixed(0)}',
                      style: AppTextStyles.text13RegularGrey500,
                    ),
                  ],
                ),
              ),

              // Over budget badge
              if (isOverBudget)
                Row(
                  children:  [
                    Icon(Icons.error_outline_rounded,
                        size: 18, color: AppColors.redColor),
                    const Gap(4),
                    Text(
                      'Over',
                      style: AppTextStyles.text13MediumRedColor,
                    ),
                  ],
                ),
            ],
          ),

          const Gap(16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor:  AppColors.cardBackgroundColor,
              valueColor: AlwaysStoppedAnimation(
                isOverBudget ? AppColors.errorColor: AppColors.primary,
              ),
            ),
          ),

          const Gap(8),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$pctLabel% used',
              style: AppTextStyles.text12RegularLightGray,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String icon) {
    switch (icon) {
      case 'utensils':   return Icons.restaurant_rounded;
      case 'shopping':   return Icons.shopping_bag_rounded;
      case 'car':        return Icons.directions_car_rounded;
      case 'receipt':    return Icons.receipt_long_rounded;
      case 'film':       return Icons.movie_rounded;
      default:           return Icons.category_rounded;
    }
  }
}
