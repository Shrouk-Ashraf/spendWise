import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:spendwise/core/theme/app_text_styles.dart';

import '../../../../core/theme/app_colors.dart';

class BalanceCard extends StatelessWidget {
  final double totalBalance ;
  final double monthlyExpenses ;
  final double monthlySavings ;
  const BalanceCard({super.key, required this.totalBalance, required this.monthlyExpenses, required this.monthlySavings});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: Colors.grey[100]!),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Balance',
                style: AppTextStyles.text12RegularGray600,
              ),
              const Gap(4),
              Text(
                '\$${totalBalance.toStringAsFixed(2)}',
                style: AppTextStyles.text32BoldBlack,
              ),
              const Gap(16),
              // Quick Summary
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.trending_down,
                            color: Colors.red,
                            size: 20,
                          ),
                        ),
                        const Gap(12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expenses',
                              style: AppTextStyles.text11RegularGrey600,
                            ),
                            const Gap(2),
                            Text(
                              '\$${monthlyExpenses.toStringAsFixed(2)}',
                              style:  AppTextStyles.text13RegularBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.savings_outlined,
                            color: AppColors.primary,
                            size: 20,
                          ),
                        ),
                        const Gap(12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Savings',
                              style: AppTextStyles.text11RegularGrey600,
                            ),
                            const Gap(2),
                            Text(
                              '\$${monthlySavings.toStringAsFixed(2)}',
                              style: AppTextStyles.text13RegularBlack,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
