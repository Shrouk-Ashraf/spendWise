import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';

class SavingsOverviewCard extends StatelessWidget {
  const SavingsOverviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.lightBlueColor, AppColors.darkBlueColor],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color:  AppColors.lightBlueColor.withValues(alpha: 0.35),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Savings Progress',
            style: TextStyle(
                color: Color(0xFFBFDBFE), fontSize: 14),
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '\$${totalSaved.toStringAsFixed(0)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '/ \$${totalTarget.toStringAsFixed(0)}',
                style: const TextStyle(
                    color: Color(0xFFBFDBFE), fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: overallPct,
              minHeight: 10,
              backgroundColor: Colors.white.withOpacity(0.25),
              valueColor: const AlwaysStoppedAnimation(Colors.white),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            '\$${remaining.toStringAsFixed(0)} left to reach all goals',
            style: const TextStyle(
                color: Color(0xFFBFDBFE), fontSize: 13),
          ),
        ],
      ),
    );
  }
}
